Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C7A9E15946A
	for <lists+kvmarm@lfdr.de>; Tue, 11 Feb 2020 17:08:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4A64D4AE96;
	Tue, 11 Feb 2020 11:08:06 -0500 (EST)
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
	with ESMTP id Om6Apr-1O7bG; Tue, 11 Feb 2020 11:08:06 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2128B4AE8D;
	Tue, 11 Feb 2020 11:08:05 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 77C204A5A3
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Feb 2020 11:08:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XuNiY9I38hTN for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 Feb 2020 11:08:02 -0500 (EST)
Received: from us-smtp-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 573AD4A982
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Feb 2020 11:08:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581437282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Etqe//LRT3pM0qb1yDS4eT6yXsXnFgQdg0GzoAov0i4=;
 b=dtOW5kD+4Mwd+tNHaZct6UHGktVFG6cNyD81osNO6O0hBQr5xhvUYw9jK4c2oHc1kynG20
 PVNoRuTXg0ASM25DBj7LO54m4gI4icPvnZ01v0BI0dQXvm2cMVrbe5X+qNnoauUsXKK9Ph
 TJhFN4/awBiFfmpanMrisUT2OUDEYTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-Kn7K1Dw3MZq2mN87tEtssA-1; Tue, 11 Feb 2020 11:07:43 -0500
X-MC-Unique: Kn7K1Dw3MZq2mN87tEtssA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65421107ACC4;
 Tue, 11 Feb 2020 16:07:41 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E648F26FDF;
 Tue, 11 Feb 2020 16:07:35 +0000 (UTC)
Date: Tue, 11 Feb 2020 17:07:33 +0100
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [kvm-unit-tests PATCH v2 0/9] KVM: arm64: PMUv3 Event Counter
 Tests
Message-ID: <20200211160733.zbqh3vbscdfgkkcd@kamzik.brq.redhat.com>
References: <20200130112510.15154-1-eric.auger@redhat.com>
 <CAFEAcA8iBvM2xguW2_6OFWDjPPEzEorief4F2aoh0Vitp466rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFEAcA8iBvM2xguW2_6OFWDjPPEzEorief4F2aoh0Vitp466rQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: kvm-devel <kvm@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Murray <andrew.murray@arm.com>,
 kvmarm@lists.cs.columbia.edu, Eric Auger <eric.auger.pro@gmail.com>
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

On Tue, Feb 11, 2020 at 03:42:38PM +0000, Peter Maydell wrote:
> On Thu, 30 Jan 2020 at 11:25, Eric Auger <eric.auger@redhat.com> wrote:
> >
> > This series implements tests exercising the PMUv3 event counters.
> > It tests both the 32-bit and 64-bit versions. Overflow interrupts
> > also are checked. Those tests only are written for arm64.
> >
> > It allowed to reveal some issues related to SW_INCR implementation
> > (esp. related to 64-bit implementation), some problems related to
> > 32-bit <-> 64-bit transitions and consistency of enabled states
> > of odd and event counters (See [1]).
> >
> > Overflow interrupt testing relies of one patch from Andre
> > ("arm: gic: Provide per-IRQ helper functions") to enable the
> > PPI 23, coming from "arm: gic: Test SPIs and interrupt groups"
> > (https://patchwork.kernel.org/cover/11234975/). Drew kindly
> > provided "arm64: Provide read/write_sysreg_s".
> >
> > All PMU tests can be launched with:
> > ./run_tests.sh -g pmu
> > Tests also can be launched individually. For example:
> > ./arm-run arm/pmu.flat -append 'chained-sw-incr'
> >
> > With KVM:
> > - chain-promotion and chained-sw-incr are known to be failing.
> >   [1] proposed a fix.
> > - On TX2, I have some random failures due to MEM_ACCESS event
> >   measured with a great disparity. This is not observed on
> >   other machines I have access to.
> > With TCG:
> > - all new tests are skipped
> 
> I'm having a go at using this patchset to test the support
> I'm adding for TCG for the v8.1 and v8.4 PMU extensions...
> 
> Q1: how can I get run_tests.sh to pass extra arguments to
> QEMU ? The PMU events check will fail unless QEMU gets
> the '-icount 8' to enable cycle-counting, but although
> the underlying ./arm/run lets you add arbitrary extra
> arguments to QEMU, run_tests.sh doesn't seem to. Trying to
> pass them in via "QEMU=/path/to/qemu -icount 8" doesn't
> work either.

Alex Bennee once submit a patch[*] allowing that to work, but
it never got merged. I just rebased it and tried it, but it
doesn't work now. Too much has changed in the run scripts
since his posting. I can try to rework it though.

[*] https://github.com/rhdrjones/kvm-unit-tests/commit/9a8574bfd924f3e865611688e26bb12e53821747

> 
> Q2: do you know why arm/pmu.c:check_pmcr() insists that
> PMCR.IMP is non-zero? The comment says "simple sanity check",
> but architecturally a zero IMP field is permitted (meaning
> "go look at MIDR_EL1 instead"). This causes TCG to fail this
> test on '-cpu max', because in that case we set PMCR.IMP
> to the same thing as MIDR_EL1.Implementer which is 0
> ("software use", since QEMU is software...)

Probably just a misunderstanding on the part of the author (and
reviewers). Maybe Eric can fix that while preparing this series.

Thanks,
drew

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
