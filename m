Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F339E1AD89E
	for <lists+kvmarm@lfdr.de>; Fri, 17 Apr 2020 10:33:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 725424B0D6;
	Fri, 17 Apr 2020 04:33:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8tZurWwqv0j1; Fri, 17 Apr 2020 04:33:41 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B91A94B1C8;
	Fri, 17 Apr 2020 04:33:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2F5C04B10B
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 04:33:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HKx4sRvYfLuA for <kvmarm@lists.cs.columbia.edu>;
 Fri, 17 Apr 2020 04:33:38 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2EE9F4B0C2
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 04:33:38 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 03FC22137B;
 Fri, 17 Apr 2020 08:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587112417;
 bh=ow4RCTCsHairYh31RKkXUJ67Orlffoz/KgRIiU9/xD0=;
 h=From:To:Cc:Subject:Date:From;
 b=AUYZg2TH0dZxNaOepILkxW+Ra012+kuvwrSXHloeyp4ALuW9GUq7t7hjc8bhCVi4c
 WBWhdY5bBSg/xFSQJxvaF4KuGC1220VTm0NzW4sm3XRWzoAeoaYvbEs9+AG7w+/PCp
 9cVVbvmAJlCdEIR34eUSduigKNatkMPUkXlFgHTc=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jPMRL-00473f-4u; Fri, 17 Apr 2020 09:33:35 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v2 0/6] KVM: arm: vgic fixes for 5.7
Date: Fri, 17 Apr 2020 09:33:13 +0100
Message-Id: <20200417083319.3066217-1-maz@kernel.org>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, yuzenghui@huawei.com,
 eric.auger@redhat.com, Andre.Przywara@arm.com, julien@xen.org,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Julien Grall <julien@xen.org>, Andre Przywara <Andre.Przywara@arm.com>
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

Here's a few vgic fixes I've been piling on during the merge window,
plus a couple that Zenghui contributed, and which I added to the mix.

The first patch is a silly off-by-one bug in the ACTIVE handling code,
where we miss fail to stop the guest if writing to the first set of
GICv2 SPIs. Oopsie boo.

The second patch improves the handling of the ACTIVE registers, which
we never synchronise on the read side (the distributor state can only
be updated when the vcpu exits). Let's fix it the same way we do it on
the write side (stop-the-world, read, restart). Yes, this is
expensive.

The following two patches deal with an issue where we consider the HW
state of an interrupt when responding to a userspace access. We should
never do this, as the guest shouldn't be running at this stage and if
it is, it is absolutely fine to return random bits to userspace. It
could also be that there is no active guest context at this stage, and
you end up with an Oops, which nobody really enjoys.

The last two patches fix a couple of memory leaks.

Marc Zyngier (4):
  KVM: arm: vgic: Fix limit condition when writing to GICD_I[CS]ACTIVER
  KVM: arm: vgic: Synchronize the whole guest on GIC{D,R}_I{S,C}ACTIVER
    read
  KVM: arm: vgic: Only use the virtual state when userspace accesses
    enable bits
  KVM: arm: vgic-v2: Only use the virtual state when userspace accesses
    pending bits

Zenghui Yu (2):
  KVM: arm64: vgic-v3: Retire all pending LPIs on vcpu destroy
  KVM: arm64: vgic-its: Fix memory leak on the error path of
    vgic_add_lpi()

 virt/kvm/arm/vgic/vgic-init.c    |   6 +
 virt/kvm/arm/vgic/vgic-its.c     |  11 +-
 virt/kvm/arm/vgic/vgic-mmio-v2.c |  16 ++-
 virt/kvm/arm/vgic/vgic-mmio-v3.c |  28 +++--
 virt/kvm/arm/vgic/vgic-mmio.c    | 183 +++++++++++++++++++++++++------
 virt/kvm/arm/vgic/vgic-mmio.h    |  19 ++++
 6 files changed, 207 insertions(+), 56 deletions(-)

-- 
2.26.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
