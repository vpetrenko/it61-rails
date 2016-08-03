class GoogleService
  # rubocop:disable Metrics/AbcSize
  def self.add_event_to_calendar(refresh_token, event)
    client = Google::APIClient.new(
      access_type: "offline",
      scope: "https://www.googleapis.com/auth/calendar"
    )

    client.authorization.client_id = Rails.application.secrets.google_key
    client.authorization.client_secret = Rails.application.secrets.google_secret
    client.authorization.grant_type = "refresh_token"
    client.authorization.refresh_token = refresh_token

    # refresh token
    client.authorization.fetch_access_token!

    service = client.discovered_api("calendar", "v3")

    client.execute(
      api_method: service.events.insert,
      parameters: { calendarId: "primary" },
      body: JSON.dump(to_google_calendar_obj(event)),
      headers: { "Content-Type" => "application/json" }
    )
  end

  def self.to_google_calendar_obj(event)
    {
      summary: :event.title,
      location: :event.places.first.address,
      description: :event.description.nil? ? "" : event.description,
      start: {
        dateTime: event.started_at.iso8601,
      },
      end: {
        dateTime: event.started_at.iso8601,
      },
    }
  end
end
