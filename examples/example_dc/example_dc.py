from pydc import DC

def main():
    dc = DC("example_dc.pl", 200) #default is 0 sample (will produce nan if later on no n_samples provided)
    prob1 = dc.query("drawn(1)~=1")
    print(prob1)
    prob2 = dc.query("drawn(1)~=1", n_samples=2000)
    print(prob2)

if __name__ == "__main__":
    main()
