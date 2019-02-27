from libcpp cimport bool, float
from libc.stdint cimport uint32_t
from libcpp.string cimport string
from libcpp.vector cimport vector

import os
import sys
from collections import OrderedDict


try:
   from problog.logic import Term
except:
   plTerm_imported = False
else:
   plTerm_imported = True


def _get_file_path(model_file):
   cwd = os.getcwd()
   cwd_sys = sys.argv[0]
   cwd_sys = os.path.dirname(cwd_sys)
   path_model_file = os.path.join(cwd,cwd_sys,model_file)
   return path_model_file


def str2term(str):
   if plTerm_imported:
      term = Term.from_string(str)
      return term
   else:
      print("No install of problog found return original string")
      return str

#Distributional Clauses
cdef extern from "dc.h":
   cdef cppclass dc:
      dc() except +
      dc(string file, int n_samples) except +
      double query(string query,string evidence)
      double query(string query,string evidence, int n_samples)


cdef class DC:
   cdef dc dc_c
   def __cinit__(self, model_file, int n_samples=0):
      path_model_file = _get_file_path(model_file)
      path_model_file = path_model_file.encode("UTF-8")
      self.dc_c = dc(path_model_file, n_samples)
   def query(self, query, evidence="", int n_samples=0):
      query = query.encode("UTF-8")
      evidence = evidence.encode("UTF-8")
      if n_samples:
         result = self.dc_c.query(query, evidence, n_samples)
         return result
      else:
         result = self.dc_c.query(query, evidence)
         return result



#Dynamic Distributional Clauses
cdef extern from "ddc.h":
   cdef cppclass ddc:
      ddc() except +
      ddc(string file, int n_particles) except +
      double step(string actions, string query, double delta)
      double query(string query)
      double querylist(string args_query, string query, vector[string] &args_vec, vector[double] &prob_vec)

cdef class DDC:
   cdef ddc ddc_c
   def __cinit__(self, model_file, int n_samples=0):
      path_model_file = _get_file_path(model_file)
      path_model_file = path_model_file.encode("UTF-8")
      self.ddc_c = ddc(path_model_file, n_samples)
   def step(self, observations="", actions="", double delta=1.0):
      observations = observations.encode("UTF-8")
      actions = actions.encode("UTF-8")
      return self.ddc_c.step(actions, observations, delta)
   def query(self, query):
      query = query.encode("UTF-8")
      return self.ddc_c.query(query)
   def querylist(self, args_query, query):
      args_query = args_query.encode("UTF-8")
      query = query.encode("UTF-8")
      cdef vector[string] args_vec
      cdef vector[double] prob_vec
      self.ddc_c.querylist(args_query, query, args_vec, prob_vec)
      return OrderedDict(zip(args_vec, prob_vec))



#HYPE

#TODO make this work and test
#inherit from DDC?
cdef extern from "hype.h":
   cdef cppclass hype:
      hype() except +
      hype(string file, int n_particles) except +
      bool plan_step(
         string observations,
         bool use_abstraction,
         uint32_t nb_samples,
         uint32_t max_horizon,
         uint32_t used_horizon,
         string &best_action,
         float &total_reward,
         uint32_t &time,
         bool &stop
      )

cdef class HYPE:
   cdef hype hype_c
   def __cinit__(self, string model_file, int n_samples=0):
      path_model_file = _get_file_path(model_file)
      path_model_file = path_model_file.encode("utf-8")
      self.hype_c = hype(path_model_file, n_samples)
   def plan_step(self, string observations, uint32_t nb_samples, uint32_t max_horizon=10, uint32_t used_horizon=5, bool use_abstraction=False):
      cdef string best_action
      cdef float total_reward
      cdef uint32_t time
      cdef bool stop

      self.hype_c.plan_step(observations, use_abstraction, nb_samples, max_horizon, used_horizon,best_action,total_reward,time,stop)

      return {'best_action':best_action.decode('utf-8'), 'total_reward':total_reward, 'time':time, 'stop':stop}
