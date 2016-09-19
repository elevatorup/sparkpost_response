def stub_supply(type, body, status = 200, host = /api.sparkpost/)
  stub_request(type, host).to_return(status: status, body: body)
end
