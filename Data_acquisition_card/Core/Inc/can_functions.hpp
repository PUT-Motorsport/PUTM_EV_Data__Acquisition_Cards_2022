#pragma once

#include "PUTM_EV_CAN_LIBRARY/lib/can_interface.hpp"
#include "safety_gpio.hpp"
#include "debugIO.hpp"

namespace {
CAN_HandleTypeDef * CANinstance_ = nullptr;
}

namespace Canbus {

//will initialize the can with a blank filter
//will not return on fail
void initialize(CAN_HandleTypeDef * instance) {
	CAN_FilterTypeDef filter{};
	filter.FilterBank = 0;
	filter.FilterMode = CAN_FILTERMODE_IDMASK;
	filter.FilterFIFOAssignment = CAN_RX_FIFO0;
	filter.FilterIdHigh = 0;
	filter.FilterIdLow = 0;
	filter.FilterMaskIdHigh	= 0;
	filter.FilterMaskIdLow = 0;
	filter.FilterScale = CAN_FILTERSCALE_32BIT;
	filter.FilterActivation = ENABLE;
	filter.SlaveStartFilterBank = 14;

	if (HAL_CAN_ConfigFilter(instance, &filter) not_eq HAL_OK) {
		unrecoverableError(State::CANError);	//no point in returning if the CAN is not accessible
	}
	if (HAL_CAN_Start(instance) not_eq HAL_OK) {
		unrecoverableError(State::CANError);
	}
	if (HAL_CAN_ActivateNotification(instance, CAN_IT_RX_FIFO0_MSG_PENDING) not_eq HAL_OK) {
		unrecoverableError(State::CANError);
	}
	CANinstance_ = instance;
}

void send_main_frame(ADC1_Data volatile const * const adc1_data, ADC2_Data volatile const * const adc2_data) {
	auto safety = get_safety_state();

	PUTM_CAN::AQ_main main_frame{};
	main_frame.brake_pressure_front = adc1_data->BrakePressure1;	//fixme: but is it really the front brake pressure
	main_frame.brake_pressure_back =  adc1_data->BrakePressure2;
	main_frame.suspension_right = adc1_data->SuspensionR;
	main_frame.suspension_left = adc2_data->SuspensionL;
	main_frame.bspd = safety[static_cast<std::size_t>(Safety::BSPD)];
	main_frame.device_state = (PUTM_CAN::AQ_states) 0;	//fixme: dirty fix of not relaying 0 as safe state
	main_frame.driver_kill = safety[static_cast<std::size_t>(Safety::Driver_kill)];
	main_frame.ebs = true;	//fixme: once the feature rolls out it will have to be updated
	main_frame.inertia = true;	//fixme: not a feature
	main_frame.left_kill = safety[static_cast<std::size_t>(Safety::Left_kill)];
	main_frame.overtravel = safety[static_cast<std::size_t>(Safety::Overtravel)];
	main_frame.right_kill = safety[static_cast<std::size_t>(Safety::Right_kill)];

	//todo: braking?
	auto average_braking_pressure = (adc1_data->BrakePressure1 + adc1_data->BrakePressure2) / 2.0;

	main_frame.braking = (average_braking_pressure > BRAKING_PRESSURE_THRESHOLD);

	PUTM_CAN::Can_tx_message<typeof(main_frame)> can_tx_frame{main_frame, PUTM_CAN::can_tx_header_AQ_MAIN};

	if (CANinstance_ == nullptr) {
		unrecoverableError(State::BadInitSeq);
		return;
	}
	if (can_tx_frame.send((*CANinstance_)) not_eq HAL_OK) {
		Device::setState(State::CANMissedMsgWarning);
	}
}

void send_gyroscope_frame(int16_t x, int16_t y, int16_t z) {
	PUTM_CAN::AQ_gyroscope gyro_frame{
		.speed_x = x,
		.speed_y = y,
		.speed_z = z,
	};

	PUTM_CAN::Can_tx_message<typeof(gyro_frame)> can_tx_frame{gyro_frame, PUTM_CAN::can_tx_header_AQ_GYROSCOPE};

	if (CANinstance_ == nullptr) {
		unrecoverableError(State::BadInitSeq);
		return;
	}
	if (can_tx_frame.send((*CANinstance_)) not_eq HAL_OK) {
		Device::setState(State::CANMissedMsgWarning);
	}
}

void send_acc_frame(int16_t x, int16_t y, int16_t z) {
	PUTM_CAN::AQ_acceleration acc_frame{
		.acc_x = x,
		.acc_y = y,
		.acc_z = z,
	};

	PUTM_CAN::Can_tx_message<typeof(acc_frame)> can_tx_frame(acc_frame, PUTM_CAN::can_tx_header_AQ_ACCELERATION);

	if (CANinstance_ == nullptr) {
		unrecoverableError(State::BadInitSeq);
		return;
	}
	if (can_tx_frame.send((*CANinstance_)) not_eq HAL_OK) {
		Device::setState(State::CANMissedMsgWarning);
	}
}

void send_rtd_frame() {
	PUTM_CAN::AQ_ts_button rtd_frame{10};	//easter egg

	PUTM_CAN::Can_tx_message<typeof(rtd_frame)> can_tx_frame(rtd_frame, PUTM_CAN::can_tx_header_AQ_TS_BUTTON);

	if (CANinstance_ == nullptr) {
		unrecoverableError(State::BadInitSeq);
		return;
	}
	if (can_tx_frame.send((*CANinstance_)) not_eq HAL_OK) {
		Device::setState(State::CANMissedMsgWarning);
	}
}

}	//namespace Canbus
