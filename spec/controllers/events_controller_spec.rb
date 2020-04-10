require "rails_helper"

require_relative "../generators/authenticatable_user"

RSpec.describe EventsController, type: :controller do
  render_views

  def log_in_authenticable_user(authenticatable_user, cookies)
    user = authenticatable_user.user

    client = SIRP::Client.new(4096)
    verifier = SIRP::Verifier.new(4096)

    client_A = client.start_authentication

    challenge_and_proof = verifier.get_challenge_and_proof(
      user.username,
      user.verifier,
      user.salt,
      client_A
    )

    session = user.sessions.create!(
      proof: challenge_and_proof[:proof],
      verified: true,
    )

    client_M = client.process_challenge(
      user.username,
      authenticatable_user.password,
      challenge_and_proof.dig(:challenge, :salt),
      challenge_and_proof.dig(:challenge, :B)
    )

    cookies[:SID] = session.id
    cookies[:SM] = client_M
  end

  describe "GET new" do
    it "sets the time range based on the event[starts_at] param" do
      authenticatable_user = Generative.generate(:authenticatable_user)
      authenticatable_user.user.save!
      log_in_authenticable_user(authenticatable_user, cookies)

      get(
        :new,
        params: {
          time_range_name: :day,
          event: {
            starts_at: Time.use_zone(authenticatable_user.user.time_zone) do
              Time.zone.local(2020, 03, 03, 03).utc
            end
          },
        },
      )
      expect(assigns(:time_range)).to eq(
        Day.new(
          2020,
          03,
          03,
          time_zone: authenticatable_user.user.time_zone,
          user_id: authenticatable_user.user.id,
        )
      )
    end

    it "sets the time range type based on the time_range param" do
      authenticatable_user = Generative.generate(:authenticatable_user)
      authenticatable_user.user.save!
      log_in_authenticable_user(authenticatable_user, cookies)

      Timecop.freeze(Time.utc(2020, 04, 04, 04)) do
        get :new, params: { time_range_name: :month }
        expect(assigns(:time_range)).to eq(
          Month.new(
            2020,
            04,
            time_zone: authenticatable_user.user.time_zone,
            user_id: authenticatable_user.user.id,
          )
        )
      end
    end
  end
end
