class Rider:
    def __init__(self):
        self.captains=[
       {"name":"Ravi","available": True},
       {"name":"Arun","available":False},
       {"name":"Siva","available":True}
   ]

    def calculate_fare(self,distance,demand):
        base_fare=30
        per_km_rate=10

        fare=base_fare +(distance * per_km_rate)

        if demand > 10:
            fare *=1.5

            return fare
        
        def assign_captain(self):
             for captain in self.captains:
                if captain["available"]:
                    captain["available"]=False
                    return captain["Name"]
                return None
  
        def request_ride(self,user_name,distance,demand):
             if distance<=0:
                raise ValueError("Invalid distance")
       
             fare = self.calculate_fare(distance,demand)
             captain = self.assign_captain()
             return{
             "user":user_name,
             "captain":captain,
             "fare":fare,
             -"status":"Captain Assigned"if captain else "no Captain available"
   } 
        
r1=Rider()
r2=r1.request_ride("RamaPriya",15,12)
print(r2)
