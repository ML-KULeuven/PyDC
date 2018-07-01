from pydc import DDC
import os
dir_path = os.path.dirname(os.path.realpath(__file__))


def main():
    ddc = DDC(os.path.join(dir_path,"example_ddc_hmm.pl"), 500)
    prob_s0 = ddc.query("current(weather)~=sunny")

    ddc.step(observations="observation(activity)~=clean")
    prob_s1 = ddc.query("current(weather)~=sunny")


    print(prob_s0)
    print(prob_s1)



if __name__ == "__main__":
    main()
