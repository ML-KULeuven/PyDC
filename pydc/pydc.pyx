from libcpp cimport bool, float
from libc.stdint cimport uint32_t
from libcpp.string cimport string
from libcpp.vector cimport vector

#Distributional Clauses
cdef extern from "dc.h":
   cdef cppclass dc:
      dc() except +
      dc(string file, int n_samples) except +
      double query(string query,string evidence)
      double query(string query,string evidence, int n_samples)


cdef class DC:
   cdef dc dc_c
   def __cinit__(self, string model_file, int n_samples=0):
      self.dc_c = dc(model_file, n_samples)
   def query(self, string query, string evidence="", int n_samples=0):
      if n_samples:
         return self.dc_c.query(query, evidence, n_samples)
      else:
         return self.dc_c.query(query, evidence)



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
   def __cinit__(self, string model_file, int n_samples=0):
      self.ddc_c = ddc(model_file, n_samples)
   def step(self, string observations="", string actions="", double delta=1.0):
      return self.ddc_c.step(actions, observations, delta)
   def query(self, string query):
      return self.ddc_c.query(query)
   def querylist(self, string args_query, string query):
      cdef vector[string] args_vec
      cdef vector[double] prob_vec
      self.ddc_c.querylist(args_query, query, args_vec, prob_vec)
      return dict(zip(args_vec, prob_vec))



#HYPE
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
      self.hype_c = hype(model_file, n_samples)
   def plan_step(self, string observations, uint32_t nb_samples, uint32_t max_horizon=10, uint32_t used_horizon=5, bool use_abstraction=False):
      cdef string best_action
      cdef float total_reward
      cdef uint32_t time
      cdef bool stop

      self.plan_step(observations, use_abstraction, nb_samples, max_horizon, used_horizon,best_action,total_reward,time,stop)

      return {'best_action':best_action, 'total_reward':total_reward, 'time':time, 'stop':stop}
