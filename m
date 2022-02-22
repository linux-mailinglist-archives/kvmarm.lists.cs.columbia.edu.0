Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 518934C0086
	for <lists+kvmarm@lfdr.de>; Tue, 22 Feb 2022 18:54:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8582E4A104;
	Tue, 22 Feb 2022 12:54:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pMBqueAwymQW; Tue, 22 Feb 2022 12:54:57 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 04B7349F4E;
	Tue, 22 Feb 2022 12:54:56 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B4A3149EB1
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Feb 2022 12:54:54 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WEJv7wwlf3Z8 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 22 Feb 2022 12:54:53 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 345AD49EAA
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Feb 2022 12:54:53 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0454A6142C;
 Tue, 22 Feb 2022 17:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8629FC340E8;
 Tue, 22 Feb 2022 17:54:48 +0000 (UTC)
Date: Tue, 22 Feb 2022 17:54:45 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v11 18/40] arm64/sme: Implement traps and syscall
 handling for SME
Message-ID: <YhUjZZGaTW4FAkvM@arm.com>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-19-broonie@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220207152109.197566-19-broonie@kernel.org>
Cc: Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
 Will Deacon <will@kernel.org>, Luis Machado <luis.machado@arm.com>,
 Szabolcs Nagy <szabolcs.nagy@arm.com>, Marc Zyngier <maz@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Alan Hayward <alan.hayward@arm.com>,
 Shuah Khan <shuah@kernel.org>, kvmarm@lists.cs.columbia.edu,
 Salil Akerkar <Salil.Akerkar@arm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Mon, Feb 07, 2022 at 03:20:47PM +0000, Mark Brown wrote:
> By default all SME operations in userspace will trap.  When this happens
> we allocate storage space for the SME register state, set up the SVE
> registers and disable traps.  We do not need to initialize ZA since the
> architecture guarantees that it will be zeroed when enabled and when we
> trap ZA is disabled.
> 
> On syscall we exit streaming mode if we were previously in it and ensure
> that all but the lower 128 bits of the registers are zeroed while
> preserving the state of ZA. This follows the aarch64 PCS for SME, ZA
> state is preserved over a function call and streaming mode is exited.

I'm not sure this is entirely correct about the PCS. The caller must
disable SM if the function it calls is not compatible. But it's fine for
the kernel to impose this at the ABI level.

> @@ -409,6 +415,21 @@ static void task_fpsimd_load(void)
>  			       restore_ffr);
>  	else
>  		fpsimd_load_state(&current->thread.uw.fpsimd_state);
> +
> +	/*
> +	 * If we didn't set up any SVE registers but we do have SME
> +	 * enabled for userspace then ensure the SVE registers are
> +	 * flushed since userspace can switch to streaming mode and
> +	 * view the register state without trapping.
> +	 */
> +	if (system_supports_sme() && test_thread_flag(TIF_SME) &&
> +	    !restore_sve_regs) {
> +		int sve_vq_minus_one;
> +
> +		sve_vq_minus_one = sve_vq_from_vl(task_get_sve_vl(current)) - 1;
> +		sve_set_vq(sve_vq_minus_one);
> +		sve_flush_live(true, sve_vq_minus_one);
> +	}

Shouldn't the SVE state be flushed by the hardware when switching to
streaming mode?

> +/*
> + * As per the ABI exit SME streaming mode and clear the SVE state not
> + * shared with FPSIMD on syscall entry.
> + */
> +static inline void fp_user_discard(void)
>  {
> +	/*
> +	 * If SME is active then exit streaming mode.  If ZA is active
> +	 * then flush the SVE registers but leave userspace access to
> +	 * both SVE and SME enabled, otherwise disable SME for the
> +	 * task and fall through to disabling SVE too.  This means
> +	 * that after a syscall we never have any SME register state
> +	 * to track, if this changes the KVM code will need updating.
> +	 */

By "we never have any SME register state to track" I understand that we
drop the ZA state as well which AFAICT is not the case.

> +	if (system_supports_sme() && test_thread_flag(TIF_SME)) {
> +		u64 svcr = read_sysreg_s(SYS_SVCR_EL0);
> +
> +		if (svcr & SYS_SVCR_EL0_SM_MASK)
> +			sme_smstop_sm();
> +
> +		if (!(svcr & SYS_SVCR_EL0_ZA_MASK)) {
> +			clear_thread_flag(TIF_SME);
> +			sme_user_disable();
> +		}
> +	}

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
