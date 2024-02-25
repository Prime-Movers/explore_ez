
# !pip install googlemaps
# !pip install python_tsp

import googlemaps
gmaps_client=googlemaps.Client(key="AIzaSyCzrc2PIy4hiaVp53zFxoLhv88psoqGHsg")

# print(direction_result[0]['legs'][0]['distance'])
# print(direction_result[0]['legs'][0]['duration'])

import pandas as pd
import numpy as np
import itertools
from python_tsp.exact import solve_tsp_dynamic_programming
from python_tsp.heuristics import solve_tsp_simulated_annealing



class TSPModel:

  def __init__(self,places):
    # places=["Snow Kingdom","Kapaleeshwarar Temple","Besant Nagar Beach","Marina Beach","San Thome Church"]

    result =  []
    distance_dict={}
    for place1 in places:
      for place2 in places:
        direction_result=gmaps_client.directions(place1,place2,mode="driving")
        a=place1+" "+place2
        result.append((a,direction_result[0]['legs'][0]['distance']['text']))
        distance_dict[place1,place2]=direction_result[0]['legs'][0]['distance']['value']
    distance=[]
    for place in places:
      distance_1d=[]
      for place2 in places:
        distance_1d.append(distance_dict[place,place2]/1000)
      distance.append(distance_1d)

    distance_matrix = np.array(distance)

    permutation,distance = solve_tsp_simulated_annealing(distance_matrix)
    # permutation,distance = solve_tsp_dynamic_programming(distance_matrix)
    permutation

    route = ""
    for i in permutation:
      route+=i
      route+=", "
    return route

