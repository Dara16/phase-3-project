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

    # OCCUPANTS RESOURCE

    # Occupants index

    if req.path == ('/occupants') && req.get?
      return [200, {'Content-Type' => 'application/json'}, [Occupant.all.to_json]]
    end

    # Occupants create

    if req.path == ('/occupants') && req.post?
      body = JSON.parse(req.body.read)
      occupant = Occupant.create(body)
      return [201, {'Content-Type' => 'application/json'}, [occupant.to_json]]
    end

    # Occupants show

    if req.path.match('/occupants/') && req.get?
      id = req.path.split('/')[2]
      begin
        occupant = Occupant.find(id)
        return [200, {'Content-Type' => 'application/json'}, [occupant.to_json]]
      rescue
        return [404, {'Content-Type' => 'application/json'}, [{message: "Occupant not found"}.to_json]]
      end
    end

    # Occupants update

    if req.path.match('/occupants/') && req.patch?
      id = req.path.split('/')[2]
      body = JSON.parse(req.body.read)
      begin
        occupant = Occupant.find(id)
        occupant.update(body)
        return [202, {'Content-Type' => 'application/json'}, [occupant.to_json]]
      end
    end

    # Occupants delete

    if req.path.match('/occupants/') && req.delete?
      id = req.path.split('/')[2]
      begin
        occupant = Occupant.find(id)
        occupant.destroy
        return [200, {'Content-Type' => 'application/json'}, [{message: "Occupant Destroyed"}.to_json]]
      rescue
        return [404, {'Content-Type' => 'application/json'}, [{message: "Occupant not found"}.to_json]]
      end
    end


    # TENEMENTS RESOURCE

    # Tenements index

    if req.path == ('/tenements') && req.get?
      return [200, {'Content-Type' => 'application/json'}, [Tenement.all.to_json]]
    end

    # Tenements show

    if req.path.match('/tenements/') && req.get?
      id = req.path.split('/')[2]
      begin
        tenement = Tenement.find(id)

        return [200, {'Content-Type' => 'application/json'}, [tenement.as_json(include: :apartments).to_json]]
      rescue
        return [404, {'Content-Type' => 'application/json'}, [{message: "Building not found"}.to_json]]
      end
    end

    # Tenements Update

    if req.path.match('/tenements/') && req.patch?
      id = req.path.split('/')[2]
      body = JSON.parse(req.body.read)
      begin
        tenement = Tenement.find(id)
        tenement.update(body)
        return [202, {'Content-Type' => 'application/json'}, [tenement.to_json]]
      end
    end

    # APARTMENTS RESOURCE

    # Apartments index

    if req.path == ('/apartments') && req.get?
      return [200, {'Content-Type' => 'application/json'}, [Apartment.all.to_json]]
    end

    # Apartments show

    if req.path.match('/apartments/') && req.get?
      id = req.path.split('/')[2]
      begin
        apartment = Apartment.find(id)
      
        return [200, {'Content-Type' => 'application/json'}, [apartment.as_json(include: :occupants).to_json]]
      rescue
        return [404, {'Content-Type' => 'application/json'}, [{message: "Apartment not found"}.to_json]]
      end
    end

    # Apartments update

    if req.path.match('/apartments/') && req.patch?
      id = req.path.split('/')[2]
      body = JSON.parse(req.body.read)
      begin
        apartment = Apartment.find(id)
        apartment.update(body)
        return [202, {'Content-Type' => 'application/json'}, [apartment.to_json]]
      end
    end

  end
end
    