class Application

    @@items = [Item.new("Cherries", 1.25), Item.new("Bananas", 4.50)]
    def call(env)
      resp = Rack::Response.new
      req = Rack::Request.new(env)
  
      if req.path.match(/items/)
        item_name = req.path.split("/items/").last
        if item = @@items.find {|i| i.name == item_name}
            resp.write item.price
        else
            resp.status = 400
            resp.write "Item not found"
        end
      else
        resp.write "Route not found"
        resp.status = 404
      end
  
      resp.finish
    end
  
  
    def handle_search(search_term)
      if @@items.include?(search_term)
        return "#{search_term} is one of our items"
      else
        return "Couldn't find #{search_term}"
      end
    end
  end
  