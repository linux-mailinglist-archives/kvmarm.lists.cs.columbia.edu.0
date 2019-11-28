Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CA22F10CE16
	for <lists+kvmarm@lfdr.de>; Thu, 28 Nov 2019 18:50:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4ACC14ACF5;
	Thu, 28 Nov 2019 12:50:01 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z43veyjYUYYB; Thu, 28 Nov 2019 12:50:01 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E4DD34A650;
	Thu, 28 Nov 2019 12:49:59 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 16D194A51D
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Nov 2019 12:49:58 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yvoaadUuWDK2 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 28 Nov 2019 12:49:56 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B291740217
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Nov 2019 12:49:56 -0500 (EST)
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1iaNvP-00043C-6P; Thu, 28 Nov 2019 18:49:55 +0100
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 3/3] target/arm: Handle trapping to EL2 of AArch32 VMRS
 instructions
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Date: Thu, 28 Nov 2019 17:49:55 +0000
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <CAFEAcA_MED0Rtqo1=HNnn7v_zQZGDsoJVsbXAsdhb_sAjvJ40Q@mail.gmail.com>
References: <20191128161718.24361-1-maz@kernel.org>
 <20191128161718.24361-4-maz@kernel.org>
 <CAFEAcA_MED0Rtqo1=HNnn7v_zQZGDsoJVsbXAsdhb_sAjvJ40Q@mail.gmail.com>
Message-ID: <241a27adc76f3f6dcc96c3ef993660f7@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 kvmarm@lists.cs.columbia.edu, richard.henderson@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kvmarm@lists.cs.columbia.edu
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Peter,

Thanks for having a look at this.

On 2019-11-28 16:43, Peter Maydell wrote:
> On Thu, 28 Nov 2019 at 16:17, Marc Zyngier <maz@kernel.org> wrote:
>>
>> HCR_EL2.TID3 requires that AArch32 reads of MVFR[012] are trapped to
>> EL2, and that HCR_EL2.TID0 does the same for reads of FPSID.
>> In order to handle this, introduce a new TCG helper function that
>> checks for these control bits before executing the VMRC instruction.
>>
>> Tested with a hacked-up version of KVM/arm64 that sets the control
>> bits for 32bit guests.
>>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  target/arm/helper-a64.h        |  2 ++
>>  target/arm/internals.h         |  8 ++++++++
>>  target/arm/translate-vfp.inc.c | 12 +++++++++---
>>  target/arm/vfp_helper.c        | 27 +++++++++++++++++++++++++++
>>  4 files changed, 46 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
>> index a915c1247f..311ced44e6 100644
>> --- a/target/arm/helper-a64.h
>> +++ b/target/arm/helper-a64.h
>> @@ -102,3 +102,5 @@ DEF_HELPER_FLAGS_3(autda, TCG_CALL_NO_WG, i64, 
>> env, i64, i64)
>>  DEF_HELPER_FLAGS_3(autdb, TCG_CALL_NO_WG, i64, env, i64, i64)
>>  DEF_HELPER_FLAGS_2(xpaci, TCG_CALL_NO_RWG_SE, i64, env, i64)
>>  DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
>> +
>> +DEF_HELPER_3(check_hcr_el2_trap, void, env, int, int)
>> diff --git a/target/arm/internals.h b/target/arm/internals.h
>> index f5313dd3d4..5a55e960de 100644
>> --- a/target/arm/internals.h
>> +++ b/target/arm/internals.h
>> @@ -430,6 +430,14 @@ static inline uint32_t syn_simd_access_trap(int 
>> cv, int cond, bool is_16bit)
>>          | (cv << 24) | (cond << 20) | (1 << 5);
>>  }
>>
>> +static inline uint32_t syn_vmrs_trap(int rt, int reg)
>> +{
>> +    return (EC_FPIDTRAP << ARM_EL_EC_SHIFT)
>> +        | ARM_EL_IL
>> +        | (1 << 24) | (0xe << 20) | (7 << 14)
>> +        | (reg << 10) | (rt << 5) | 1;
>> +}
>> +
>>  static inline uint32_t syn_sve_access_trap(void)
>>  {
>>      return EC_SVEACCESSTRAP << ARM_EL_EC_SHIFT;
>> diff --git a/target/arm/translate-vfp.inc.c 
>> b/target/arm/translate-vfp.inc.c
>> index 85c5ef897b..4c435b6c35 100644
>> --- a/target/arm/translate-vfp.inc.c
>> +++ b/target/arm/translate-vfp.inc.c
>> @@ -759,15 +759,21 @@ static bool trans_VMSR_VMRS(DisasContext *s, 
>> arg_VMSR_VMRS *a)
>>      }
>>
>>      if (a->l) {
>> +        TCGv_i32 tcg_rt, tcg_reg;
>> +
>>          /* VMRS, move VFP special register to gp register */
>>          switch (a->reg) {
>> +        case ARM_VFP_MVFR0:
>> +        case ARM_VFP_MVFR1:
>> +        case ARM_VFP_MVFR2:
>>          case ARM_VFP_FPSID:
>> +            tcg_rt = tcg_const_i32(a->rt);
>> +            tcg_reg = tcg_const_i32(a->reg);
>
> Since the syndrome value depends only on these two things,
> you might as well generate the full syndrome value at
> translate time rather than doing it at runtime; then
> you only need to pass one thing through to the helper rather
> than two.

OK. This means that the register check in check_hcr_el2_trap
will need to extract the register value from the syndrome.
Not a big deal, but maybe slightly less readable.

>
>> +            gen_helper_check_hcr_el2_trap(cpu_env, tcg_rt, 
>> tcg_reg);
>
> This helper call is potentially going to throw an exception
> at runtime. QEMU's JIT doesn't write back all the state
> of the CPU to the CPU state structure fields for helper
> calls, so to avoid losing non-written-back state there are
> two possible approaches:
>
> (1) manually write back the state before the call; for
> aarch32 this looks like
>             gen_set_condexec(s);
>             gen_set_pc_im(s, s->pc_curr);
> (you can see this done before we call the access_check_cp_reg()
> helper, for instance)
>
> (2) in the helper function, instead of raise_exception(),
> call raise_exception_ra(..., GETPC())
> This says "when we take the exception, also re-sync the
> CPU state by looking at the host PC value in the JITted
> code (ie the address of the callsite of the helper) and
> looking through a table for this translation block that
> cross-references the host PC against the guest PC and
> condexec values for that point in execution".
>
> Option 1 is better if the expectation is that the trap will
> be taken always, often or usually; option 2 is what we
> use if the trap is unlikely (it's how we handle
> exceptions on guest load/store insns, which are the main
> reason we have the mechanism at all).
>
> Since it's unlikely that guest code will be doing ID
> register accesses in hot codepaths, I'd go with option 1,
> mostly just for consistency with how we do coprocessor
> register access-check function calls.

Ah, very interesting stuff. There is a lot of "magic" happening
in QEMU, and I wondered about the emulated state at some point,
until I forgot about it!

On a vaguely tangential subject, how are conditional instructions
JIT-ed? I could perfectly imagine a conditional VMRS instruction,
but none of the code I looked at seem to care about it. Or is
that done before the access itself is actually emitted?

>
>> +            /* fall through */
>>          case ARM_VFP_FPEXC:
>>          case ARM_VFP_FPINST:
>>          case ARM_VFP_FPINST2:
>> -        case ARM_VFP_MVFR0:
>> -        case ARM_VFP_MVFR1:
>> -        case ARM_VFP_MVFR2:
>>              tmp = load_cpu_field(vfp.xregs[a->reg]);
>>              break;
>>          case ARM_VFP_FPSCR:
>> diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
>> index 9710ef1c3e..44e538e51c 100644
>> --- a/target/arm/vfp_helper.c
>> +++ b/target/arm/vfp_helper.c
>> @@ -1322,4 +1322,31 @@ float64 HELPER(frint64_d)(float64 f, void 
>> *fpst)
>>      return frint_d(f, fpst, 64);
>>  }
>>
>> +void HELPER(check_hcr_el2_trap)(CPUARMState *env, int rt, int reg)
>> +{
>> +    if (arm_current_el(env) != 1) {
>> +        return;
>> +    }
>> +
>> +    switch (reg) {
>> +    case ARM_VFP_MVFR0:
>> +    case ARM_VFP_MVFR1:
>> +    case ARM_VFP_MVFR2:
>> +        if (!(arm_hcr_el2_eff(env) & HCR_TID3)) {
>> +            return;
>> +        }
>> +        break;
>> +    case ARM_VFP_FPSID:
>> +        if (!(arm_hcr_el2_eff(env) & HCR_TID0)) {
>> +            return;
>> +        }
>> +        break;
>> +    default:
>> +        /* Shouldn't be here... */
>> +        return;
>
> We usually write 'impossible' default cases as:
>            g_assert_not_reached();

Noted, thanks.

I'll wait a bit for additional reviews (if any), and then repost the
series with these fixes in.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
