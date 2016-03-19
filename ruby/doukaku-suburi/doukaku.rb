require 'bundler'
Bundler.require

def solve(input)
  group = input.scan(/\((.*?)\)/).flatten

  while group.count > 1
    p group
    group = process(group)
  end

  ?( + group.first + ?)
end

def process(group, force: false)
  m = Math.log(group.count, 2).floor
  if 2 ** m == group.count || force
    group.reverse.each_slice(2).map do |(r, l)|
      puts "#{l} vs #{r}"

      winner = if l
                 battle(l, r)
               else
                 r
               end

      puts "#{winner} win"

      winner
    end.reverse
  else
    x = group.count - (group.count - 2 ** m) * 2

    group.first(x) + process(group[x..-1], force: true)
  end
end

def battle(left, right)
  repeated_left  = left  * right.length
  repeated_right = right * left.length

  return left if repeated_left == repeated_right

  repeated_left.chars.zip(repeated_right.chars) do |l, r|
    next if l == r

    case l
    when ?R
      return r == ?S ? left : right
    when ?P
      return r == ?R ? left : right
    when ?S
      return r == ?P ? left : right
    else
      raise 'what?'
    end
  end
end

def test(input, expect)
  actual = solve(input)

  if actual == expect
    puts "OK: #{input}"
  else
    raise "NG: #{input} : expect #{expect} but got #{actual}"
  end
end

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
