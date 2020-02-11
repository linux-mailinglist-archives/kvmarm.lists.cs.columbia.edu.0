Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF91159363
	for <lists+kvmarm@lfdr.de>; Tue, 11 Feb 2020 16:41:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2E2214A650;
	Tue, 11 Feb 2020 10:41:51 -0500 (EST)
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
	with ESMTP id Fa15FV1yBJA5; Tue, 11 Feb 2020 10:41:51 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D5A2F4AE9E;
	Tue, 11 Feb 2020 10:41:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B60864A955
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Feb 2020 10:41:48 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EJJvUvMj+BRn for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 Feb 2020 10:41:47 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9EAE74A650
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Feb 2020 10:41:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581435707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Me6Yl2hEf1fSLuJ7KJ8ksgl99ilpDB0p8vApU6vbJIQ=;
 b=aEQ/2wM128e3J38X+3XTezaJkLJABCqXhMEvdBlNAqPB02l1FlZ729OAv943uUTOYpO4MP
 6d39okIH1NkAdsWCyz98ztF11H6UrMnNkXvmSG4nyUndPe00EhJLeCZVACj+ySpWKaOpKd
 Bc+ntvhsPySSEVRuUH81gl1uG5UvBtc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-PVhv-p2jNxCOXzR0GDTDMw-1; Tue, 11 Feb 2020 10:41:43 -0500
X-MC-Unique: PVhv-p2jNxCOXzR0GDTDMw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9413802701;
 Tue, 11 Feb 2020 15:41:41 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D52355C10D;
 Tue, 11 Feb 2020 15:41:37 +0000 (UTC)
Date: Tue, 11 Feb 2020 16:41:35 +0100
From: Andrew Jones <drjones@redhat.com>
To: Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH kvm-unit-tests v2] arm64: timer: Speed up gic-timer-state
 check
Message-ID: <20200211154135.vxxkpstt4cpoyqsp@kamzik.brq.redhat.com>
References: <20200211133705.1398-1-drjones@redhat.com>
 <60c6c4c7-1d6b-5b64-adc1-8e96f45332c6@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <60c6c4c7-1d6b-5b64-adc1-8e96f45332c6@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: andre.przywara@arm.com, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

On Tue, Feb 11, 2020 at 10:50:58PM +0800, Zenghui Yu wrote:
> Hi Drew,
> 
> On 2020/2/11 21:37, Andrew Jones wrote:
> > Let's bail out of the wait loop if we see the expected state
> > to save over six seconds of run time. Make sure we wait a bit
> > before reading the registers and double check again after,
> > though, to somewhat mitigate the chance of seeing the expected
> > state by accident.
> > 
> > We also take this opportunity to push more IRQ state code to
> > the library.
> > 
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> 
> [...]
> 
> > +
> > +enum gic_irq_state gic_irq_state(int irq)
> 
> This is a *generic* name while this function only deals with PPI.
> Maybe we can use something like gic_ppi_state() instead?  Or you
> will have to take all interrupt types into account in a single
> function, which is not a easy job I think.

Very good point.

> 
> > +{
> > +	enum gic_irq_state state;
> > +	bool pending = false, active = false;
> > +	void *base;
> > +
> > +	assert(gic_common_ops);
> > +
> > +	switch (gic_version()) {
> > +	case 2:
> > +		base = gicv2_dist_base();
> > +		pending = readl(base + GICD_ISPENDR) & (1 << PPI(irq));
> > +		active = readl(base + GICD_ISACTIVER) & (1 << PPI(irq));
> > +		break;
> > +	case 3:
> > +		base = gicv3_sgi_base();
> > +		pending = readl(base + GICR_ISPENDR0) & (1 << PPI(irq));
> > +		active = readl(base + GICR_ISACTIVER0) & (1 << PPI(irq));
> 
> And you may also want to ensure that the 'irq' is valid for PPI().
> Or personally, I'd just use a real PPI number (PPI(info->irq)) as
> the input parameter of this function.

Indeed, if we want to make this a general function we should require
the caller to pass PPI(irq).

> 
> > +		break;
> > +	}
> > +
> > +	if (!active && !pending)
> > +		state = GIC_IRQ_STATE_INACTIVE;
> > +	if (pending)
> > +		state = GIC_IRQ_STATE_PENDING;
> > +	if (active)
> > +		state = GIC_IRQ_STATE_ACTIVE;
> > +	if (active && pending)
> > +		state = GIC_IRQ_STATE_ACTIVE_PENDING;
> > +
> > +	return state;
> > +}
> > 
> 
> Otherwise,
> 
> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
> Tested-by: Zenghui Yu <yuzenghui@huawei.com>

Thanks, but I guess I should squash in changes to make this function more
general. My GIC/SPI skills are weak, so I'm not sure this is right,
especially because the SPI stuff doesn't yet have a user to validate it.
However, if all reviewers think it's correct, then I'll squash it into
the arm/queue branch. I've added Andre and Eric to help review too.

Thanks,
drew


diff --git a/arm/timer.c b/arm/timer.c
index ae5fdbf54b35..44621b4f2967 100644
--- a/arm/timer.c
+++ b/arm/timer.c
@@ -189,9 +189,9 @@ static bool gic_timer_check_state(struct timer_info *info,
 	/* Wait for up to 1s for the GIC to sample the interrupt. */
 	for (i = 0; i < 10; i++) {
 		mdelay(100);
-		if (gic_irq_state(info->irq) == expected_state) {
+		if (gic_irq_state(PPI(info->irq)) == expected_state) {
 			mdelay(100);
-			if (gic_irq_state(info->irq) == expected_state)
+			if (gic_irq_state(PPI(info->irq)) == expected_state)
 				return true;
 		}
 	}
diff --git a/lib/arm/gic.c b/lib/arm/gic.c
index 0563b31132c8..3924dd1d1ee6 100644
--- a/lib/arm/gic.c
+++ b/lib/arm/gic.c
@@ -150,22 +150,37 @@ void gic_ipi_send_mask(int irq, const cpumask_t *dest)
 enum gic_irq_state gic_irq_state(int irq)
 {
 	enum gic_irq_state state;
-	bool pending = false, active = false;
-	void *base;
+	void *ispendr, *isactiver;
+	bool pending, active;
 
 	assert(gic_common_ops);
 
 	switch (gic_version()) {
 	case 2:
-		base = gicv2_dist_base();
-		pending = readl(base + GICD_ISPENDR) & (1 << PPI(irq));
-		active = readl(base + GICD_ISACTIVER) & (1 << PPI(irq));
+		ispendr = gicv2_dist_base() + GICD_ISPENDR;
+		isactiver = gicv2_dist_base() + GICD_ISACTIVER;
 		break;
 	case 3:
-		base = gicv3_sgi_base();
-		pending = readl(base + GICR_ISPENDR0) & (1 << PPI(irq));
-		active = readl(base + GICR_ISACTIVER0) & (1 << PPI(irq));
+		if (irq < GIC_NR_PRIVATE_IRQS) {
+			ispendr = gicv3_sgi_base() + GICR_ISPENDR0;
+			isactiver = gicv3_sgi_base() + GICR_ISACTIVER0;
+		} else {
+			ispendr = gicv3_dist_base() + GICD_ISPENDR;
+			isactiver = gicv3_dist_base() + GICD_ISACTIVER;
+		}
 		break;
+	default:
+		assert(0);
+	}
+
+	if (irq < GIC_NR_PRIVATE_IRQS) {
+		pending = readl(ispendr) & (1 << irq);
+		active = readl(isactiver) & (1 << irq);
+	} else {
+		int offset = (irq - GIC_FIRST_SPI) / 32;
+		int mask = 1 << ((irq - GIC_FIRST_SPI) % 32);
+		pending = readl(ispendr + offset) & mask;
+		active = readl(isactiver + offset) & mask;
 	}
 
 	if (!active && !pending)

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
