from libcpp.string cimport string


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


cdef extern from "ddc.h":
   cdef cppclass ddc:
      ddc() except +
      ddc(string file, int n_particles) except +
      double step(string actions, string query, double delta)
      double query(string query)

cdef class DDC:
   cdef ddc ddc_c
   def __cinit__(self, string model_file, int n_samples=0):
      self.ddc_c = ddc(model_file, n_samples)
   def step(self, string observations, string actions="", double delta=1.0):
      return self.ddc_c.step(actions, observations, delta)
   def query(self, string query):
      return self.ddc_c.query(query)
