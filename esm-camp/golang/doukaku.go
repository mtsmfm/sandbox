// bin/dr go run golang/doukaku.go
package main
import (
  "fmt"
  "regexp"
  "strings"
  "unicode/utf8"
  "math"
  //"time"
  "sync"
)
func main() {
  var wg sync.WaitGroup

  test := func(input string, expected string) {
    wg.Add(1)
    go func(i string, e string) {
      _test(i, e)
      wg.Done()
    }(input, expected)
  }
  test("(RSP)(R)(RPS)(SP)", "(RPS)")
  test("(RPS)(R)(RSP)(SP)(RSSP)", "(RSSP)")
  test("(RRS)(S)(PSSRP)(PRP)(PSS)", "(PRP)")
  test("(PRS)(PSPP)(PRSP)(S)(RR)(SSPR)", "(PRS)")
  test("(PSRP)(PR)(RPRPR)(PSSPP)(SP)(SRPP)(PR)", "(SP)")
  test("(SPS)(R)(RP)(RRS)(PPRRS)(R)(RS)(RRRRP)", "(PPRRS)")
  test("(PPSRPSPRR)(SP)(PPPRSSR)(PS)(P)(PRSPS)(PP)(RSSR)", "(SP)")
  test("(SRPRS)(SRPSRS)(SPP)(RSPRS)(S)(SRPSPS)(RSPPSSS)(SRRPRRPSSP)", "(RSPPSSS)")
  test("(SRSPSPRS)(RRPRRS)(PRRRRS)(RSSPSSRPS)(PPSSPPRR)(PPSPPS)(PSPSPSSSP)(RPPRPS)", "(PRRRRS)")
  test("(S)(PRS)(RSRP)(S)(PPRR)(PP)(RSSS)(P)(RSR)", "(PP)")
  test("(RPR)(P)(PSPR)(SRSRP)(SR)(RPPR)(RRS)(S)(SSPR)(PRPR)", "(RPPR)")
  test("(PSR)(PPPRR)(S)(SP)(S)(PR)(SPSRP)(PPSRR)(PRPPR)(RRRSP)(SR)", "(S)")
  test("(PPRPP)(RSS)(PRS)(R)(RPRP)(SPSSS)(RR)(PPRP)(RSSS)(RSRS)(RP)", "(PPRPP)")
  test("(P)(PPPRR)(RRRS)(RR)(RPRSS)(PRSPS)(PP)(R)(PSR)(RPPP)(RP)(SSSR)", "(PSR)")
  test("(SR)(P)(RRPRP)(RSPS)(PSS)(SPPSP)(RRPS)(PR)(RRRSR)(PRR)(SSS)(RRRSS)(P)", "(SR)")
  test("(PS)(RS)(RR)(RPR)(SR)(SP)(PRP)(PPS)(R)(PRSP)(SSPRR)(SP)(PPR)(RSRR)", "(SSPRR)")
  test("(RRRRS)(SRPRR)(PPSS)(SSPPS)(R)(R)(P)(P)(PSSPR)(S)(RRPP)(SPRR)(S)(RR)(S)", "(PSSPR)")
  test("(RRPSSRP)(SSSSSP)(RRSPSS)(PRSRRSRP)(SSRRRRR)(SS)(SSSSSSPPRP)(R)(SRRSR)(PPPSRSP)(RPRS)(RSRPPRS)(RPPPPRPR)(PRRSR)(RPRRSR)", "(PPPSRSP)")
  test("(SSSRS)(SRPSS)(RSPRP)(RPPPP)(S)(PPRPS)(RRR)(PS)(RPSPS)(SPP)(PSRS)(P)(P)(RR)(S)(PSP)", "(RSPRP)")
  test("(SPP)(PR)(SR)(SRPSP)(P)(RR)(SSPP)(RS)(RRRPP)(R)(PRSPS)(RRPP)(RRRSS)(RRRSS)(RSP)(SRPR)(PPS)", "(SPP)")
  test("(SSS)(SSPR)(SSRR)(P)(PRRSP)(RRRPP)(PR)(P)(PS)(PPR)(R)(SRPSR)(R)(S)(SSPRS)(SRPR)(PPPR)(SRS)", "(SSRR)")
  test("(PR)(R)(PRPS)(PR)(S)(PS)(R)(P)(R)(SS)(RP)(SS)(SP)(R)(SPR)(RPR)(PSP)(PPPS)(SPRPR)", "(RP)")
  test("(SPS)(SRPR)(P)(SPPS)(SS)(RS)(SRPPS)(SRSPS)(RSR)(SRPR)(P)(SPSS)(SRS)(SP)(RSRRP)(PP)(SR)(RPRP)(P)(SPPPS)", "(RSR)")
  test("(SSRSP)(SPRRPRSPS)(SPSPS)(PRPR)(SPPRP)(RS)(SPSSPRRS)(PSPPRPSSP)(PSRRRRRP)(SPPRS)(SRRP)(SP)(SRSPRPSP)(PPSRRRSR)(PPPSSRSR)(PRPSPS)(SRR)(RP)(SP)(RSRPSPSSRS)", "(RS)")
  test("(RRPS)(SRPR)(PS)(SPPS)(SS)(RS)(SRPPS)(SRSPS)(RSR)(SRPR)(P)(SPSS)(SRS)(SP)(RSRRP)(PP)(SR)(RPRP)(P)(SPPPS)", "(RRPS)")
  test("(S)(PRSRR)(PP)(PSSSS)(SR)(SRRP)(PRRPR)(PRSS)(SPPS)(SS)(SPPR)(SSRSR)(PSRPP)(RSP)(R)(P)(PPP)(SS)(SP)(SSSS)(RRSR)", "(SRRP)")
  test("(PS)(R)(R)(S)(S)(SSP)(RPPP)(RPSP)(RPRR)(R)(SRRSS)(RSR)(PS)(PRP)(SSSS)(S)(SSSR)(SS)(PSP)(RS)(PSRSR)(SR)", "(SR)")
  test("(RSPSS)(RRSSR)(S)(RRS)(PSSRR)(S)(RPRRP)(RS)(PS)(RR)(R)(PSRR)(RPPRP)(SSS)(S)(R)(R)(SRSS)(PR)(S)(RRPPS)(S)(SSPRR)", "(RRS)")
  test("(PSSS)(RRRPR)(PRPP)(RSSS)(RR)(RP)(PPS)(PSR)(SPS)(SRSS)(R)(RR)(SPRSR)(RSPRP)(RRSP)(SSRRP)(RSSSR)(PPSS)(PRS)(RRSRS)(PS)(SS)(P)(SPR)", "(PRPP)")
  test("(RSRPSS)(RPPRPRRSP)(PRPSRSRPPP)(SSRSSRS)(RPS)(SP)(PPPPPSSP)(RRRPSR)(PSR)(SRSRSSR)(RPSSSRP)(RRSPSSSPPR)(RS)(SRRRSPRP)(PR)(RSSRPSSS)(PPRRRRRR)(RRSRP)(RRR)(PSPRSSPRP)(PRPPRSSRP)(SPPSPSS)(PSS)(RPS)(P)(RRSRSP)(PS)(RRPSSSRR)(RR)(PPPSPRPR)(PS)(PRSSRPR)(RRP)(PSRPR)(PS)(R)(RRPP)(SSPPSS)(SRPSSS)(RRSRRPRPP)", "(SPPSPSS)")

  wg.Wait()
}

type game struct {
  left  string
  right string
}

func (g game) repeated_left() string {
  return strings.Repeat(g.left, utf8.RuneCountInString(g.right))
}

func (g game) repeated_right() string {
  return strings.Repeat(g.right, utf8.RuneCountInString(g.left))
}

func (g game) is_even() bool {
  return g.repeated_left() == g.repeated_right()
}

func (g game) battle() string {
  if g.is_even() { return g.left }

  for i, x := range g.repeated_left() {
    l:= string(x)
    r:= string(g.repeated_right()[i])

    if l == r {
      // noop
    } else if l == "R" && r == "S" || l == "S" && r == "P" || l == "P" && r == "R" {
      return g.left
    } else {
      return g.right
    }
  }

  return "xxx"
}

func battle(left string, right string) string {
  //fmt.Printf("%s vs %s\n", left, right)
  //time.Sleep(time.Second)

  return game{left: left, right: right}.battle()
}

func process(members []string) (next_members []string) {
  var channels []chan string

  for i := 0; i < len(members); i+=2 {
    channel := make(chan string)
    channels = append(channels, channel)

    go func(left string, right string) {
      channel <- battle(left, right)
    }(members[i], members[i+1])
  }

  for _, channel := range channels {
    next_members = append(next_members, <- channel)
  }
  return
}

func split(members []string) (seed, not_seed []string) {
  seed_count := int(math.Pow(2, math.Ceil(math.Log2(float64(len(members)))))) - len(members)

  for i, member := range members {
    if i < seed_count {
      seed = append(seed, member)
    } else {
      not_seed = append(not_seed, member)
    }
  }

  return
}

func solve(input string) string {
  members := parse(input)
  members, not_seed := split(members)

  for _, member := range process(not_seed) {
    members = append(members, member)
  }

  for len(members) > 1 {
    members = process(members)
  }

  return fmt.Sprintf("(%s)", members[0])
}

func parse(input string) []string {
  re := regexp.MustCompile(`\(.*?\)`)
  var members []string
  for _, member := range re.FindAllString(input, -1) {
    members = append(members, strings.Replace(strings.Replace(member, "(", "", -1), ")", "", -1))
  }
  return members
}

func _test(input string, expected string) {
  actual := solve(input)
  if actual == expected {
    fmt.Printf("%s: OK\n", input)
  } else {
    fmt.Println(fmt.Sprintf("NG"))
    fmt.Println(fmt.Sprintf("expected: %s, but got: %s", expected, actual))
  }
}
