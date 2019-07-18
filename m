Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 204CD6CE59
	for <lists+kvmarm@lfdr.de>; Thu, 18 Jul 2019 14:57:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9599F4A56D;
	Thu, 18 Jul 2019 08:56:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.8
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, HTML_MESSAGE=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id twJckj8f-DAz; Thu, 18 Jul 2019 08:56:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A43914A56B;
	Thu, 18 Jul 2019 08:56:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 67FD24A558
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Jul 2019 08:56:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9yn3D551JxOS for <kvmarm@lists.cs.columbia.edu>;
 Thu, 18 Jul 2019 08:56:54 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 900014A543
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Jul 2019 08:56:54 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35E3D344;
 Thu, 18 Jul 2019 05:56:54 -0700 (PDT)
Received: from [10.1.196.217] (e121566-lin.cambridge.arm.com [10.1.196.217])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26E143F71F;
 Thu, 18 Jul 2019 05:56:53 -0700 (PDT)
Subject: Re: [PATCH 43/59] KVM: arm64: nv: Trap and emulate AT instructions
 from virtual EL2
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>, Marc Zyngier <marc.zyngier@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
References: <20190621093843.220980-1-marc.zyngier@arm.com>
 <20190621093843.220980-44-marc.zyngier@arm.com>
 <4cd8b175-7676-0d3b-2853-365a346e1302@arm.com>
 <852db652-5318-113b-083c-baf12eb58593@semihalf.com>
 <6537c8d2-3bda-788e-8861-b70971a625cb@arm.com>
Message-ID: <3f70012e-8e1a-f821-c815-45824097dd3b@arm.com>
Date: Thu, 18 Jul 2019 13:56:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <6537c8d2-3bda-788e-8861-b70971a625cb@arm.com>
Content-Language: en-US
Cc: Andre Przywara <andre.przywara@arm.com>, Dave Martin <Dave.Martin@arm.com>
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
Content-Type: multipart/mixed; boundary="===============1635193716111357028=="
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

This is a multi-part message in MIME format.
--===============1635193716111357028==
Content-Type: multipart/alternative;
 boundary="------------4F41C881589DF8B10D385DCF"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------4F41C881589DF8B10D385DCF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 7/18/19 1:36 PM, Alexandru Elisei wrote:
> On 7/18/19 1:13 PM, Tomasz Nowicki wrote:
>
>> Hello Alex,
>>
>> On 09.07.2019 15:20, Alexandru Elisei wrote:
>>> On 6/21/19 10:38 AM, Marc Zyngier wrote:
>>>> From: Jintack Lim <jintack.lim@linaro.org>
>>>>
>>>> When supporting nested virtualization a guest hypervisor executing AT
>>>> instructions must be trapped and emulated by the host hypervisor,
>>>> because untrapped AT instructions operating on S1E1 will use the wrong
>>>> translation regieme (the one used to emulate virtual EL2 in EL1 instead
>>> I think that should be "regime".
>>>
>>>> of virtual EL1) and AT instructions operating on S12 will not work from
>>>> EL1.
>>>>
>>>> This patch does several things.
>>>>
>>>> 1. List and define all AT system instructions to emulate and document
>>>> the emulation design.
>>>>
>>>> 2. Implement AT instruction handling logic in EL2. This will be used to
>>>> emulate AT instructions executed in the virtual EL2.
>>>>
>>>> AT instruction emulation works by loading the proper processor
>>>> context, which depends on the trapped instruction and the virtual
>>>> HCR_EL2, to the EL1 virtual memory control registers and executing AT
>>>> instructions. Note that ctxt->hw_sys_regs is expected to have the
>>>> proper processor context before calling the handling
>>>> function(__kvm_at_insn) implemented in this patch.
>>>>
>>>> 4. Emulate AT S1E[01] instructions by issuing the same instructions in
>>>> EL2. We set the physical EL1 registers, NV and NV1 bits as described in
>>>> the AT instruction emulation overview.
>>> Is item number 3 missing, or is that the result of an unfortunate typo?
>>>
>>>> 5. Emulate AT A12E[01] instructions in two steps: First, do the stage-1
>>>> translation by reusing the existing AT emulation functions.  Second, do
>>>> the stage-2 translation by walking the guest hypervisor's stage-2 page
>>>> table in software. Record the translation result to PAR_EL1.
>>>>
>>>> 6. Emulate AT S1E2 instructions by issuing the corresponding S1E1
>>>> instructions in EL2. We set the physical EL1 registers and the HCR_EL2
>>>> register as described in the AT instruction emulation overview.
>>>>
>>>> 7. Forward system instruction traps to the virtual EL2 if the corresponding
>>>> virtual AT bit is set in the virtual HCR_EL2.
>>>>
>>>>    [ Much logic above has been reworked by Marc Zyngier ]
>>>>
>>>> Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
>>>> ---
>>>>   arch/arm64/include/asm/kvm_arm.h |   2 +
>>>>   arch/arm64/include/asm/kvm_asm.h |   2 +
>>>>   arch/arm64/include/asm/sysreg.h  |  17 +++
>>>>   arch/arm64/kvm/hyp/Makefile      |   1 +
>>>>   arch/arm64/kvm/hyp/at.c          | 217 +++++++++++++++++++++++++++++++
>>>>   arch/arm64/kvm/hyp/switch.c      |  13 +-
>>>>   arch/arm64/kvm/sys_regs.c        | 202 +++++++++++++++++++++++++++-
>>>>   7 files changed, 450 insertions(+), 4 deletions(-)
>>>>   create mode 100644 arch/arm64/kvm/hyp/at.c
>>>>
>> [...]
>>
>>>> +
>>>> +void __kvm_at_s1e01(struct kvm_vcpu *vcpu, u32 op, u64 vaddr)
>>>> +{
>>>> +	struct kvm_cpu_context *ctxt = &vcpu->arch.ctxt;
>>>> +	struct mmu_config config;
>>>> +	struct kvm_s2_mmu *mmu;
>>>> +
>>>> +	/*
>>>> +	 * We can only get here when trapping from vEL2, so we're
>>>> +	 * translating a guest guest VA.
>>>> +	 *
>>>> +	 * FIXME: Obtaining the S2 MMU for a a guest guest is horribly
>>>> +	 * racy, and we may not find it.
>>>> +	 */
>>>> +	spin_lock(&vcpu->kvm->mmu_lock);
>>>> +
>>>> +	mmu = lookup_s2_mmu(vcpu->kvm,
>>>> +			    vcpu_read_sys_reg(vcpu, VTTBR_EL2),
>>>> +			    vcpu_read_sys_reg(vcpu, HCR_EL2));
>>>  From ARM DDI 0487D.b, the description for AT S1E1R (page C5-467, it's the same
>>> for the other at s1e{0,1}* instructions):
>>>
>>> [..] Performs stage 1 address translation, with permisions as if reading from
>>> the given virtual address from EL1, or from EL2 [..], using the following
>>> translation regime:
>>> - If HCR_EL2.{E2H,TGE} is {1, 1}, the EL2&0 translation regime, accessed from EL2.
>>>
>>> If the guest is VHE, I don't think there's any need to switch mmus. The AT
>>> instruction will use the physical EL1&0 translation regime already on the
>>> hardware (assuming host HCR_EL2.TGE == 0), which is the vEL2&0 regime for the
>>> guest hypervisor.
>> Here we want to run AT for L2 (guest guest) EL1&0 regime and not the L1 
>> (guest hypervisor) so we have to lookup and switch to nested VM MMU 
>> context. Or did I miss your point?
>>
>> Thanks,
>> Tomasz
> What I mean to say is that if the L1 guest has set HCR_EL2.{E2H, TGE} = {1, 1}, then the instruction affects the vEL2&0 translation regime (as per the instruction description in the arhitecture), which is already loaded. The AT instruction will affect the L1 guest hypervisor, not the L2 guest.
>
> In other words:
>
> if (!vcpu_el2_e2h_is_set(vcpu) || !vcpu_el2_tge_is_set(vcpu))
>         /* switch mmus, the instruction affects the L2 guest (the guest guest) */
> else
>         /* do not switch mmus, the instruction affects the L1 guest hypervisor which is loaded */
>
> I hope this makes things clearer.
>
>
I realized where the confusion comes from (nested virtualization is hard). Let me rephrase it again, maybe this time I will get it right.

What I mean to say is that if the L1 guest has set HCR_EL2.{E2H, TGE} = {1, 1}, then the instruction uses the vEL2&0 translation regime (as per the instruction description in the architecture), meaning it uses the translation regime for the L1 guest hypervisor, and the stage 2 for that regime is already loaded.

In other words:

if (!vcpu_el2_e2h_is_set(vcpu) || !vcpu_el2_tge_is_set(vcpu))
        /* the instruction affects the L2 guest (the guest guest), find the stage 2 mmu associated with that guest */
else
        /* the instruction affects the L1 guest hypervisor, the stage 2 mmu for it is already loaded */

Thanks,
Alex 


--------------4F41C881589DF8B10D385DCF
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix"><tt>On 7/18/19 1:36 PM, Alexandru
        Elisei wrote:</tt><br>
    </div>
    <blockquote type="cite"
      cite="mid:6537c8d2-3bda-788e-8861-b70971a625cb@arm.com">
      <pre class="moz-quote-pre" wrap="">On 7/18/19 1:13 PM, Tomasz Nowicki wrote:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Hello Alex,

On 09.07.2019 15:20, Alexandru Elisei wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On 6/21/19 10:38 AM, Marc Zyngier wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">From: Jintack Lim <a class="moz-txt-link-rfc2396E" href="mailto:jintack.lim@linaro.org">&lt;jintack.lim@linaro.org&gt;</a>

When supporting nested virtualization a guest hypervisor executing AT
instructions must be trapped and emulated by the host hypervisor,
because untrapped AT instructions operating on S1E1 will use the wrong
translation regieme (the one used to emulate virtual EL2 in EL1 instead
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">I think that should be "regime".

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">of virtual EL1) and AT instructions operating on S12 will not work from
EL1.

This patch does several things.

1. List and define all AT system instructions to emulate and document
the emulation design.

2. Implement AT instruction handling logic in EL2. This will be used to
emulate AT instructions executed in the virtual EL2.

AT instruction emulation works by loading the proper processor
context, which depends on the trapped instruction and the virtual
HCR_EL2, to the EL1 virtual memory control registers and executing AT
instructions. Note that ctxt-&gt;hw_sys_regs is expected to have the
proper processor context before calling the handling
function(__kvm_at_insn) implemented in this patch.

4. Emulate AT S1E[01] instructions by issuing the same instructions in
EL2. We set the physical EL1 registers, NV and NV1 bits as described in
the AT instruction emulation overview.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Is item number 3 missing, or is that the result of an unfortunate typo?

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">5. Emulate AT A12E[01] instructions in two steps: First, do the stage-1
translation by reusing the existing AT emulation functions.  Second, do
the stage-2 translation by walking the guest hypervisor's stage-2 page
table in software. Record the translation result to PAR_EL1.

6. Emulate AT S1E2 instructions by issuing the corresponding S1E1
instructions in EL2. We set the physical EL1 registers and the HCR_EL2
register as described in the AT instruction emulation overview.

7. Forward system instruction traps to the virtual EL2 if the corresponding
virtual AT bit is set in the virtual HCR_EL2.

   [ Much logic above has been reworked by Marc Zyngier ]

Signed-off-by: Jintack Lim <a class="moz-txt-link-rfc2396E" href="mailto:jintack.lim@linaro.org">&lt;jintack.lim@linaro.org&gt;</a>
Signed-off-by: Marc Zyngier <a class="moz-txt-link-rfc2396E" href="mailto:marc.zyngier@arm.com">&lt;marc.zyngier@arm.com&gt;</a>
Signed-off-by: Christoffer Dall <a class="moz-txt-link-rfc2396E" href="mailto:christoffer.dall@arm.com">&lt;christoffer.dall@arm.com&gt;</a>
---
  arch/arm64/include/asm/kvm_arm.h |   2 +
  arch/arm64/include/asm/kvm_asm.h |   2 +
  arch/arm64/include/asm/sysreg.h  |  17 +++
  arch/arm64/kvm/hyp/Makefile      |   1 +
  arch/arm64/kvm/hyp/at.c          | 217 +++++++++++++++++++++++++++++++
  arch/arm64/kvm/hyp/switch.c      |  13 +-
  arch/arm64/kvm/sys_regs.c        | 202 +++++++++++++++++++++++++++-
  7 files changed, 450 insertions(+), 4 deletions(-)
  create mode 100644 arch/arm64/kvm/hyp/at.c

</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">[...]

</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">+
+void __kvm_at_s1e01(struct kvm_vcpu *vcpu, u32 op, u64 vaddr)
+{
+	struct kvm_cpu_context *ctxt = &amp;vcpu-&gt;arch.ctxt;
+	struct mmu_config config;
+	struct kvm_s2_mmu *mmu;
+
+	/*
+	 * We can only get here when trapping from vEL2, so we're
+	 * translating a guest guest VA.
+	 *
+	 * FIXME: Obtaining the S2 MMU for a a guest guest is horribly
+	 * racy, and we may not find it.
+	 */
+	spin_lock(&amp;vcpu-&gt;kvm-&gt;mmu_lock);
+
+	mmu = lookup_s2_mmu(vcpu-&gt;kvm,
+			    vcpu_read_sys_reg(vcpu, VTTBR_EL2),
+			    vcpu_read_sys_reg(vcpu, HCR_EL2));
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap=""> From ARM DDI 0487D.b, the description for AT S1E1R (page C5-467, it's the same
for the other at s1e{0,1}* instructions):

[..] Performs stage 1 address translation, with permisions as if reading from
the given virtual address from EL1, or from EL2 [..], using the following
translation regime:
- If HCR_EL2.{E2H,TGE} is {1, 1}, the EL2&amp;0 translation regime, accessed from EL2.

If the guest is VHE, I don't think there's any need to switch mmus. The AT
instruction will use the physical EL1&amp;0 translation regime already on the
hardware (assuming host HCR_EL2.TGE == 0), which is the vEL2&amp;0 regime for the
guest hypervisor.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Here we want to run AT for L2 (guest guest) EL1&amp;0 regime and not the L1 
(guest hypervisor) so we have to lookup and switch to nested VM MMU 
context. Or did I miss your point?

Thanks,
Tomasz
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
What I mean to say is that if the L1 guest has set HCR_EL2.{E2H, TGE} = {1, 1}, then the instruction affects the vEL2&amp;0 translation regime (as per the instruction description in the arhitecture), which is already loaded. The AT instruction will affect the L1 guest hypervisor, not the L2 guest.

In other words:

if (!vcpu_el2_e2h_is_set(vcpu) || !vcpu_el2_tge_is_set(vcpu))
        /* switch mmus, the instruction affects the L2 guest (the guest guest) */
else
        /* do not switch mmus, the instruction affects the L1 guest hypervisor which is loaded */

I hope this makes things clearer.


</pre>
    </blockquote>
    <pre>I realized where the confusion comes from (nested virtualization is hard). Let me rephrase it again, maybe this time I will get it right.

What I mean to say is that if the L1 guest has set HCR_EL2.{E2H, TGE} = {1, 1}, then the instruction uses the vEL2&amp;0 translation regime (as per the instruction description in the architecture), meaning it uses the translation regime for the L1 guest hypervisor, and the stage 2 for that regime is already loaded.

In other words:

if (!vcpu_el2_e2h_is_set(vcpu) || !vcpu_el2_tge_is_set(vcpu))
        /* the instruction affects the L2 guest (the guest guest), find the stage 2 mmu associated with that guest */
else
        /* the instruction affects the L1 guest hypervisor, the stage 2 mmu for it is already loaded */

Thanks,
Alex 
</pre>
  </body>
</html>

--------------4F41C881589DF8B10D385DCF--

--===============1635193716111357028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

--===============1635193716111357028==--
