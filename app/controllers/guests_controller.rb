class GuestsController < ApplicationController
    before_action :set_guest, only: %i[ show edit update destroy ]

    def index
      @guest = Guest.search(params[:search])
      if @guest.present?
        render :search
      end
    end

    def show
    end

    def edit
      @guest = Guest.find(params[:id])
      @scort_guests = ScortGuest.where(guest_id: params[:id])
      respond_to do |format|
        format.js
      end
    end

    def cancel_invitation
      @guest = Guest.find(params[:guest_id])
      @guest.update(confirmation: 2)
      respond_to do |format|
        format.html {redirect_to root_path, notice: 'Mensaje recibido'}
      end
    end

    def update
      cedula_guest = guest_params[:guest_id]
      email = guest_params[:email]
      if cedula_guest.present?
        respond_to do |format|
          if @guest.update(id_guest: cedula_guest, email: email, confirmation: 1)
            if guest_params[:scort_guests].present?
              @scorts_objs = []
              guest_params[:scort_guests].each do |scort|
                cedula_scort= scort[1]["id_scort"]
                if cedula_scort.present?
                  @scort_guests = ScortGuest.find(scort[0])
                  @scort_guests.update(id_scort: scort[1]["id_scort"], confirmation: 1)
                  @scorts_objs << @scort_guests
                else
                  @scort_guests = ScortGuest.find(scort[0])
                  @scort_guests.update(confirmation: 2)
                end
              end
            end
             #Enviar correo
             GuestMailer.send_confirmation(guest: @guest, scort: @scorts_objs).deliver_now
            format.html {redirect_to root_path, notice: 'Confirmado exitosamente.'}
            format.json {render :edit, status: :ok, location: @guest}
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @guest.errors, status: :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
          if @guest.update(confirmation: 2)
            @scorts_objs = []
            guest_params[:scort_guests].each do |scort|
              cedula_scort= scort[1]["id_scort"]
              if cedula_guest.present?
                @scort_guests = ScortGuest.find(scort[0])
                @scort_guests.update(id_scort: scort[1]["id_scort"], confirmation: 1)
                @scorts_objs << @scort_guests
              else
                @scort_guests = ScortGuest.find(scort[0])
                @scort_guests.update(confirmation: 2)
              end
            end
            # Enviar correo
            GuestMailer.send_confirmation(guest: @guest, scort: @scorts_objs).deliver_now
            format.html {redirect_to root_path, notice: 'Mensaje recibido exitosamente.'}
            format.json {render :edit, status: :ok, location: @guest}
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @guest.errors, status: :unprocessable_entity }
          end
        end
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_guest
        @guest = Guest.find(params[:id])
      end


      # Only allow a list of trusted parameters through.
      def guest_params
        params.require(:guest).permit(:id_guest, :email, :search, :guest_id, scort_guests: [:id_scort, :scort_id])
      end
  end
