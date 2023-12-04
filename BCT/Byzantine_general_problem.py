from collections import Counter


class general:
    def __init__(self,id,is_T=False):
        self.id=id
        self.other_g = []
        self.orders = []
        self.is_T = is_T
    def __call__(self,m,order):
        self.om_Algo(commmander=self,m=m,order=order)
    def nextOrder(self,is_T,order,i):
        if is_T:
            if i%2==0:
                return "Attack" if order=="Retreat" else "Retreat"
        return order
    def om_Algo(self,commmander,m,order):
        if m<0:
            self.orders.append(order)
        elif m==0:
            for i,l in enumerate(self.other_g):
                l.om_Algo(commmander=self,m=(m-1),order=self.nextOrder(self.is_T,order,i))
        else:
             for i,l in enumerate(self.other_g):
                if l is not self and l is not commmander:
                    l.om_Algo(commmander=self,m=(m-1),order=self.nextOrder(self.is_T,order,i))
    @property
    def finalDecision(self):
        c = Counter(self.orders)
        return c.most_common()
    


def init_generals(generalList):
    # generalList = input_string.split(",")
    final_general_list  = []
    for i,spec in enumerate(generalList):
        g = general(i)
        if spec=="l":
            pass
        elif spec=="t":
            g.is_T = True
        else:
            print("Error, Invalid General List")
            exit(1)
        final_general_list.append(g)
    for g in final_general_list:
        g.other_g = final_general_list
    return final_general_list
def printDecision(generals):
    for i,l in enumerate(generals):
        print("General {:} - {:}".format(i,l.finalDecision))


m=1
g = "l, t, l"
o = "Attack"
general_spec = [x.strip() for x in g.split(',')]
generals = init_generals(general_spec)

generals[0](m=m,order=o)
printDecision(generals)



# output:
# General 0 - [('Retreat', 1), ('Attack', 1)]
# General 1 - [('Attack', 2)]
# General 2 - [('Retreat', 1), ('Attack', 1)]