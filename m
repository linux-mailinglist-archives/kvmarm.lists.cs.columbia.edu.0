Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CB99234804A
	for <lists+kvmarm@lfdr.de>; Wed, 24 Mar 2021 19:19:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 20C844B368;
	Wed, 24 Mar 2021 14:19:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KZQI8JnkwNL6; Wed, 24 Mar 2021 14:19:37 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0ED584B376;
	Wed, 24 Mar 2021 14:19:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9B1AF4B376
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Mar 2021 14:19:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x5ZzDbGg2rxG for <kvmarm@lists.cs.columbia.edu>;
 Wed, 24 Mar 2021 14:19:33 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A95F54B368
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Mar 2021 14:19:33 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 34BD361A0E;
 Wed, 24 Mar 2021 18:19:30 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lP86K-003a1f-4q; Wed, 24 Mar 2021 18:19:28 +0000
From: Marc Zyngier <maz@kernel.org>
To: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 Shenming Lu <lushenming@huawei.com>
Subject: Re: [PATCH v5 0/6] KVM: arm64: Add VLPI migration support on GICv4.1
Date: Wed, 24 Mar 2021 18:19:25 +0000
Message-Id: <161660992482.2080654.11109199563385851665.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210322060158.1584-1-lushenming@huawei.com>
References: <20210322060158.1584-1-lushenming@huawei.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: will@kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, eric.auger@redhat.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, lushenming@huawei.com,
 alex.williamson@redhat.com, yuzenghui@huawei.com, wanghaibin.wang@huawei.com,
 lorenzo.pieralisi@arm.com, cohuck@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cornelia Huck <cohuck@redhat.com>
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

On Mon, 22 Mar 2021 14:01:52 +0800, Shenming Lu wrote:
> In GICv4.1, migration has been supported except for (directly-injected)
> VLPI. And GICv4.1 Spec explicitly gives a way to get the VLPI's pending
> state (which was crucially missing in GICv4.0). So we make VLPI migration
> capable on GICv4.1 in this series.
> 
> In order to support VLPI migration, we need to save and restore all
> required configuration information and pending states of VLPIs. But
> in fact, the configuration information of VLPIs has already been saved
> (or will be reallocated on the dst host...) in vgic(kvm) migration.
> So we only have to migrate the pending states of VLPIs specially.
> 
> [...]

Applied to next, thanks!

[1/6] irqchip/gic-v3-its: Add a cache invalidation right after vPE unmapping
      commit: 301beaf19739cb6e640ed44e630e7da993f0ecc8
[2/6] irqchip/gic-v3-its: Drop the setting of PTZ altogether
      commit: c21bc068cdbe5613d3319ae171c3f2eb9f321352
[3/6] KVM: arm64: GICv4.1: Add function to get VLPI state
      commit: 80317fe4a65375fae668672a1398a0fb73eb9023
[4/6] KVM: arm64: GICv4.1: Try to save VLPI state in save_pending_tables
      commit: f66b7b151e00427168409f8c1857970e926b1e27
[5/6] KVM: arm64: GICv4.1: Restore VLPI pending state to physical side
      commit: 12df7429213abbfa9632ab7db94f629ec309a58b
[6/6] KVM: arm64: GICv4.1: Give a chance to save VLPI state
      commit: 8082d50f4817ff6a7e08f4b7e9b18e5f8bfa290d

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
