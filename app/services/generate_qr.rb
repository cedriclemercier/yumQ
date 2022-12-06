class GenerateQr < ApplicationService
  attr_reader :restaurant

  def initialize(restaurant, hostname=nil)
    @restaurant = restaurant
    @hostname = hostname
  end
  
  include Rails.application.routes.url_helpers

  require "rqrcode"

  def port
    if Rails.env.development?
      return ':3000'
    else
      return ''
    end
  end

  def call
    qr_id = SecureRandom.hex
    qr_url = url_for(controller: 'wait_queue',
            action: 'create',
            id: restaurant.id,
            only_path: false,
            protocol: 'http',
            source: 'from_qr',
            code:qr_id,
            host:@hostname + port()
            )

    qrcode = RQRCode::QRCode.new(qr_url)

    png = qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: "black",
      file: nil,
      fill: "white",
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 240
    )


    IO.binwrite("tmp/#{qr_id}.png", png.to_s) # Saving the generated qr code files into the tmp directory.

    blob = ActiveStorage::Blob.create_after_upload!(
      io: File.open("tmp/#{qr_id}.png"), # Retrieving the qr codes
      filename: qr_id,
      content_type: 'png'
    )

    restaurant.qr_code.attach(blob)
  end

end