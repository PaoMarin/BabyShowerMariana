class GuestMailer < ApplicationMailer
        def send_confirmation(params)
            @guest = params[:guest]
            @scorts_objs = params[:scort]
            mail(to: @guest.email, subject: "Confirmación de asistencia Baby Shower Mariana")
        end

        def send_reminder(guest)
            @guest = guest
            mail(to: @guest.email, subject: "Recordatorio Baby Shower Mariana")
        end
end
