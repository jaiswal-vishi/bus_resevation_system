class ReservationMailer < ApplicationMailer
	def booking_confirmation(reservation)
		@user = reservation.user
    mail(to: @user.email, subject: 'Booking Confimation From Nextbus')
	end

	def cancel_reservation(reservation)
		@user = reservation.user
    mail(to: @user.email, subject: 'Booking Reservation Cancelled From Nextbus')
	end
end
