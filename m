Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CA2DB17F6DA
	for <lists+kvmarm@lfdr.de>; Tue, 10 Mar 2020 12:56:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 634544A51F;
	Tue, 10 Mar 2020 07:56:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NhxS5OGIUW8l; Tue, 10 Mar 2020 07:56:56 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 502CE4A524;
	Tue, 10 Mar 2020 07:56:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 877C24A4A0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Mar 2020 07:56:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2PvpZ6DPl0+2 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 10 Mar 2020 07:56:53 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 741D14A1B0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Mar 2020 07:56:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583841413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mkbbEKW7QEXShSOEzrtREPglmDREmtovE720FoZTixg=;
 b=Fj5t5XMnV1YL3LKRFGqEAgpyYeGy+0kCX5hX/oCGEi5TvUlqDCI86rrK+ae2NIbDFcR0cV
 2Bpe26cp46cro89qnTLFmGl7hICkLxv5F7RhBCMLKUNm5ZZNDi1YUidXMmSDyJtqLgg1Cn
 4Aa1c7+OrnbjHd7mkgFZ4PCvxBFdKHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-7XoWPANpNouHhszEpiwCag-1; Tue, 10 Mar 2020 07:56:51 -0400
X-MC-Unique: 7XoWPANpNouHhszEpiwCag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5F13800EBD;
 Tue, 10 Mar 2020 11:56:49 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58D325C545;
 Tue, 10 Mar 2020 11:56:44 +0000 (UTC)
Date: Tue, 10 Mar 2020 12:56:42 +0100
From: Andrew Jones <drjones@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 03/13] arm/arm64: gic: Introduce
 setup_irq() helper
Message-ID: <20200310115642.vr7rx3gacl6xpjrf@kamzik.brq.redhat.com>
References: <20200309102420.24498-1-eric.auger@redhat.com>
 <20200309102420.24498-4-eric.auger@redhat.com>
 <20200309105601.3hm2kfhuufgxoydl@kamzik.brq.redhat.com>
 <3e1e2c24-2f30-03f2-ca9c-a2d99aba0740@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3e1e2c24-2f30-03f2-ca9c-a2d99aba0740@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: thuth@redhat.com, kvm@vger.kernel.org, maz@kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, andre.przywara@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
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

On Tue, Mar 10, 2020 at 12:00:19PM +0100, Auger Eric wrote:
> Hi Drew,
> On 3/9/20 11:56 AM, Andrew Jones wrote:
> > On Mon, Mar 09, 2020 at 11:24:10AM +0100, Eric Auger wrote:
> >> ipi_enable() code would be reusable for other interrupts
> >> than IPI. Let's rename it setup_irq() and pass an interrupt
> >> handler pointer.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>
> >> ---
> >>
> >> v2 -> v3:
> >> - do not export setup_irq anymore
> >> ---
> >>  arm/gic.c | 20 +++++++-------------
> >>  1 file changed, 7 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/arm/gic.c b/arm/gic.c
> >> index fcf4c1f..abf08c7 100644
> >> --- a/arm/gic.c
> >> +++ b/arm/gic.c
> >> @@ -34,6 +34,7 @@ static struct gic *gic;
> >>  static int acked[NR_CPUS], spurious[NR_CPUS];
> >>  static int bad_sender[NR_CPUS], bad_irq[NR_CPUS];
> >>  static cpumask_t ready;
> >> +typedef void (*handler_t)(struct pt_regs *regs __unused);
> > 
> > This is just irq_handler_fn, which is already defined in processor.h.
> > We don't need the __unused, not since 6b07148d06b1 ("Replace -Wextra
> > with a saner list of warning flags").
> Shall I duplicate it into ./lib/arm/asm/processor.h as well?

Yes, please do

Thanks,
drew
> 
> Thanks
> 
> Eric
> > 
> >>  
> >>  static void nr_cpu_check(int nr)
> >>  {
> >> @@ -215,20 +216,20 @@ static void ipi_test_smp(void)
> >>  	report_prefix_pop();
> >>  }
> >>  
> >> -static void ipi_enable(void)
> >> +static void setup_irq(handler_t handler)
> >>  {
> >>  	gic_enable_defaults();
> >>  #ifdef __arm__
> >> -	install_exception_handler(EXCPTN_IRQ, ipi_handler);
> >> +	install_exception_handler(EXCPTN_IRQ, handler);
> >>  #else
> >> -	install_irq_handler(EL1H_IRQ, ipi_handler);
> >> +	install_irq_handler(EL1H_IRQ, handler);
> >>  #endif
> >>  	local_irq_enable();
> >>  }
> >>  
> >>  static void ipi_send(void)
> >>  {
> >> -	ipi_enable();
> >> +	setup_irq(ipi_handler);
> >>  	wait_on_ready();
> >>  	ipi_test_self();
> >>  	ipi_test_smp();
> >> @@ -238,7 +239,7 @@ static void ipi_send(void)
> >>  
> >>  static void ipi_recv(void)
> >>  {
> >> -	ipi_enable();
> >> +	setup_irq(ipi_handler);
> >>  	cpumask_set_cpu(smp_processor_id(), &ready);
> >>  	while (1)
> >>  		wfi();
> >> @@ -295,14 +296,7 @@ static void ipi_clear_active_handler(struct pt_regs *regs __unused)
> >>  static void run_active_clear_test(void)
> >>  {
> >>  	report_prefix_push("active");
> >> -	gic_enable_defaults();
> >> -#ifdef __arm__
> >> -	install_exception_handler(EXCPTN_IRQ, ipi_clear_active_handler);
> >> -#else
> >> -	install_irq_handler(EL1H_IRQ, ipi_clear_active_handler);
> >> -#endif
> >> -	local_irq_enable();
> >> -
> >> +	setup_irq(ipi_clear_active_handler);
> >>  	ipi_test_self();
> >>  	report_prefix_pop();
> >>  }
> >> -- 
> >> 2.20.1
> >>
> 
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
