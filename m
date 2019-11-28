Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 832C410CB4B
	for <lists+kvmarm@lfdr.de>; Thu, 28 Nov 2019 16:06:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 14B754A51F;
	Thu, 28 Nov 2019 10:06:13 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sCGezz-CxV1U; Thu, 28 Nov 2019 10:06:12 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 09D4B4A5C3;
	Thu, 28 Nov 2019 10:06:12 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 689234A51F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Nov 2019 10:06:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qyd7I5jF9JUb for <kvmarm@lists.cs.columbia.edu>;
 Thu, 28 Nov 2019 10:06:09 -0500 (EST)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6FB9F4A51C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Nov 2019 10:06:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574953569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FB2NxuXo03bjG5BMgixcxMCaomV9zklTdD9jueZG8ZU=;
 b=aSDEhFB6ff/rZqWPqe6zT3jfKhoVm7itThn6djrtSrgk/N8Ghi78oeGk4IYP4Mv2emME2G
 d4imZ+yMXhUzdBxPcWkBKWH+ES/Oyfar7Q0mmSOMHLrKJcjjFLI6wNrMeMrCR+xZMmUcKh
 hBbRnfMN40a+gXJilgQy+7JC5ohawus=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-45B5G9iUN52kxXh0T1klHg-1; Thu, 28 Nov 2019 10:06:05 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A8CD107ACC5;
 Thu, 28 Nov 2019 15:06:04 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3879860BE0;
 Thu, 28 Nov 2019 15:06:03 +0000 (UTC)
Date: Thu, 28 Nov 2019 16:06:00 +0100
From: Andrew Jones <drjones@redhat.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH kvm-unit-tests] arm: Enable the VFP
Message-ID: <20191128150600.2ktf4ytattn5aop4@kamzik.brq.redhat.com>
References: <20191128143421.13815-1-drjones@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191128143421.13815-1-drjones@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 45B5G9iUN52kxXh0T1klHg-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Cc: pbonzini@redhat.com, thuth@redhat.com
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


Doh, now I need another change to deal with older compilers

diff --git a/arm/Makefile.arm b/arm/Makefile.arm
index 43b4be1e05eeb..d379a28007493 100644
--- a/arm/Makefile.arm
+++ b/arm/Makefile.arm
@@ -5,7 +5,7 @@
 #
 bits = 32
 ldarch = elf32-littlearm
-machine = -marm
+machine = -marm -mfpu=vfp
 
 # stack.o relies on frame pointers.
 KEEP_FRAME_POINTER := y


I'll send a v2 now.


On Thu, Nov 28, 2019 at 03:34:21PM +0100, Andrew Jones wrote:
> Variable argument macros frequently depend on floating point
> registers. Indeed we needed to enable the VFP for arm64 since its
> introduction in order to use printf and the like. Somehow we
> didn't need to do that for arm32 until recently when compiling
> with GCC 9.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
> 
> CC'ing Thomas because I think he had to workaround travis tests
> failing due to this issue once. Maybe travis can now be
> un-worked-around?
> 
> 
>  arm/cstart.S | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arm/cstart.S b/arm/cstart.S
> index 114726feab82..bc6219d8a3ee 100644
> --- a/arm/cstart.S
> +++ b/arm/cstart.S
> @@ -50,10 +50,11 @@ start:
>  	mov	r0, r2
>  	push	{r0-r1}
>  
> -	/* set up vector table and mode stacks */
> +	/* set up vector table, mode stacks, and enable the VFP */
>  	mov	r0, lr			@ lr is stack top (see above),
>  					@ which is the exception stacks base
>  	bl	exceptions_init
> +	bl	enable_vfp
>  
>  	/* complete setup */
>  	pop	{r0-r1}
> @@ -100,6 +101,16 @@ exceptions_init:
>  	isb
>  	mov	pc, lr
>  
> +enable_vfp:
> +	/* Enable full access to CP10 and CP11: */
> +	mov	r0, #(3 << 22 | 3 << 20)
> +	mcr	p15, 0, r0, c1, c0, 2
> +	isb
> +	/* Set the FPEXC.EN bit to enable Advanced SIMD and VFP: */
> +	mov	r0, #(1 << 30)
> +	vmsr	fpexc, r0
> +	mov	pc, lr
> +
>  .text
>  
>  .global get_mmu_off
> @@ -130,6 +141,7 @@ secondary_entry:
>  	ldr	r0, [r1]
>  	mov	sp, r0
>  	bl	exceptions_init
> +	bl	enable_vfp
>  
>  	/* finish init in C code */
>  	bl	secondary_cinit
> -- 
> 2.21.0
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
