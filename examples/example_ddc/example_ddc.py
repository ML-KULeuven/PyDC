from pydc import DDC
import os
dir_path = os.path.dirname(os.path.realpath(__file__))

def main():
    ddc = DDC(os.path.join(dir_path,"example_ddc.pl"), 500)
    prob_m1_0 = ddc.query("current(mindful(1))~=true")
    prob_v1_0 = ddc.query("current(vegan(1))~=true")
    prob_m1_v1_0 = ddc.query("(current(mindful(1))~=true, current(vegan(1))~=true)")

    ddc.step()

    prob_m1_1 = ddc.query("current(mindful(1))~=true")
    prob_v1_1 = ddc.query("current(vegan(1))~=true")
    prob_m1_v1_1 = ddc.query("(current(mindful(1))~=true, current(vegan(1))~=true)")

    ddc.step()

    prob_v_list_2 = ddc.querylist("X", "current(vegan(X)) ~= true")

    ddc.step()

    prob_a_list1_3 = ddc.querylist("X", "(current(annoying(X)) ~= true)")
    prob_a_list2_3 = ddc.querylist("X", "(current(annoying(X)) ~= false)")
    prob_v_list1_3 = ddc.querylist("X", "(current(vegan(X)) ~= true)")
    prob_v_list2_3 = ddc.querylist("X", "(current(vegan(X)) ~= false)")
    prob_av_list1_3 = ddc.querylist("X", "(current(annoying(X)) ~= true, current(vegan(X))~=true)")
    prob_av_list2_3 = ddc.querylist("X", "(current(annoying(X)) ~= true, current(vegan(X))~=false)")

    ddc.step()

    prob_list_4 = ddc.querylist("(X,Y)", "(friend(X,Y), current(vegan(X))~=true, current(vegan(Y))~=true)")


    print("timestep 0")
    print(prob_m1_0)
    print(prob_v1_0)
    print(prob_m1_v1_0)
    print("")

    print("timestep 1")
    print(prob_m1_1)
    print(prob_v1_1)
    print(prob_m1_v1_1)
    print("")

    print("timestep 2")
    print(prob_v_list_2)
    print("")

    print("timestep 3")
    print(prob_a_list1_3)
    print(prob_a_list2_3)
    print(prob_v_list1_3)
    print(prob_v_list2_3)
    print(prob_av_list1_3)
    print(prob_av_list2_3)
    print("")

    print("timestep 4")
    print(prob_list_4)


if __name__ == "__main__":
    main()
