Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4C36932B97B
	for <lists+kvmarm@lfdr.de>; Wed,  3 Mar 2021 18:36:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C92064B50F;
	Wed,  3 Mar 2021 12:36:06 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J5ncPAi1c+Fa; Wed,  3 Mar 2021 12:36:06 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 956484B505;
	Wed,  3 Mar 2021 12:36:05 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C5F574B417
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Mar 2021 12:36:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hxOIw5FhxRoh for <kvmarm@lists.cs.columbia.edu>;
 Wed,  3 Mar 2021 12:36:02 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B80474B415
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Mar 2021 12:36:02 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57FC131B;
 Wed,  3 Mar 2021 09:36:02 -0800 (PST)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 894263F7D7;
 Wed,  3 Mar 2021 09:36:01 -0800 (PST)
Date: Wed, 3 Mar 2021 17:35:57 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [kvm-unit-tests PATCH 1/6] arm64: Remove unnecessary ISB when
 writing to SPSel
Message-ID: <20210303173557.0626667d@slackpad.fritz.box>
In-Reply-To: <20210227104201.14403-2-alexandru.elisei@arm.com>
References: <20210227104201.14403-1-alexandru.elisei@arm.com>
 <20210227104201.14403-2-alexandru.elisei@arm.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Cc: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

On Sat, 27 Feb 2021 10:41:56 +0000
Alexandru Elisei <alexandru.elisei@arm.com> wrote:

> Software can use the SPSel operand to write directly to PSTATE.SP.
> According to ARM DDI 0487F.b, page D1-2332, writes to PSTATE are
> self-synchronizing and no ISB is needed:
> 
> "Writes to the PSTATE fields have side-effects on various aspects of the PE
> operation. All of these side-effects are guaranteed:
> - Not to be visible to earlier instructions in the execution stream.
> - To be visible to later instructions in the execution stream."
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>

I am always a bit wary about *removing* barriers, but I can confirm
that the ARM ARM indeed makes this guarantee above, and SP access
sounds like an easy enough case, so:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arm/cstart64.S | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arm/cstart64.S b/arm/cstart64.S
> index 0428014aa58a..fc1930bcdb53 100644
> --- a/arm/cstart64.S
> +++ b/arm/cstart64.S
> @@ -54,7 +54,6 @@ start:
>  	/* set up stack */
>  	mov	x4, #1
>  	msr	spsel, x4
> -	isb
>  	adrp    x4, stackptr
>  	add     sp, x4, :lo12:stackptr
>  

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
