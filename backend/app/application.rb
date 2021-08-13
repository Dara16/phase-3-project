class Application

  def call(env)
    res = Rack::Response.new
    req = Rack::Request.new(env)

    # test route
    if req.path.match(/test/)
      return [200, { 'Content-Type' => 'application/json' }, [ {:message => "test response!"}.to_json ]]

    else
      res.write "Path Not Found"

    end

    # Resource routes

    if req.path == '/occupants' && req.get?
      occupants = Occupant.all
      return [
        200, { 'Content-Type' => 'application/json' }, 
        [ occupants.to_json ]
      ]

    elsif req.path == '/apartments' && req.get?
      apartments = Apartment.all
      return[
        200, { 'Content-Type' => 'application/json' },
        [ apartments.to_json ]
      ]

    elsif req.path == '/tenements' && req.get?
      tenements = Tenement.all
      return[
        200, { 'Content-Type' => 'application/json' },
        [ tenements.to_json ]
      ]

    else 
      res.write "Path not found"
      
    end


  res.finish

  end

end