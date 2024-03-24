
import googlemaps
import pandas as pd
import numpy as np
import itertools
from python_tsp.exact import solve_tsp_dynamic_programming
from python_tsp.heuristics import solve_tsp_simulated_annealing

from model.apikeys import gmapsApi

class TSPModel:
  
  def __init__(self,places):
    gmaps_client=googlemaps.Client(key=gmapsApi)
    distance_dict={}
    for place1 in places:
      for place2 in places:
        direction_result=gmaps_client.directions(place1,place2,mode="driving")
        distance_dict[place1,place2]=direction_result[0]['legs'][0]['distance']['value']
    distance=[]
    for place in places:
      distance_1d=[]
      for place2 in places:
        distance_1d.append(distance_dict[place,place2]/1000)
      distance.append(distance_1d)

    distance_matrix = np.array(distance)

    permutation,distance = solve_tsp_simulated_annealing(distance_matrix)
    print(permutation)
    route = ""
    for i in range(1,len(permutation)):
      route+=places[permutation[i]]
      route+=","
    self.places=route

