from pydc import DDC

def main():
    ddc = DDC("example_ddc_hmm.pl", 500)
    prob_s0 = ddc.query("current(weather(brussels))~=sunny")

    ddc.step(observations="observation(activity~=clean")
    prob_s1 = ddc.query("current(weather)~=sunny")


    prob_s1 = ddc.query("(current(temperature(brussels))~=X, X>20)")


    print(prob_s0)
    print(prob_s1)



if __name__ == "__main__":
    main()
