Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EB290356F4E
	for <lists+kvmarm@lfdr.de>; Wed,  7 Apr 2021 16:52:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F10A4B8DD;
	Wed,  7 Apr 2021 10:52:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7+tOtnFP6kRu; Wed,  7 Apr 2021 10:52:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 79F7F4B8D2;
	Wed,  7 Apr 2021 10:52:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 91DBF4B8BF
 for <kvmarm@lists.cs.columbia.edu>; Wed,  7 Apr 2021 10:52:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xrWyS8PPXJHb for <kvmarm@lists.cs.columbia.edu>;
 Wed,  7 Apr 2021 10:52:14 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6B3B94B732
 for <kvmarm@lists.cs.columbia.edu>; Wed,  7 Apr 2021 10:52:14 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 19AB961363;
 Wed,  7 Apr 2021 14:52:13 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lU9XN-00665o-Vi; Wed, 07 Apr 2021 15:52:10 +0100
From: Marc Zyngier <maz@kernel.org>
To: Eric Auger <eric.auger@redhat.com>, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, alexandru.elisei@arm.com, drjones@redhat.com,
 eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: vgic_init kvm selftests fixup
Date: Wed,  7 Apr 2021 15:52:04 +0100
Message-Id: <161780711779.1927596.2664047995521276237.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210407135937.533141-1-eric.auger@redhat.com>
References: <20210407135937.533141-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: eric.auger@redhat.com, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, alexandru.elisei@arm.com, drjones@redhat.com,
 eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org, james.morse@arm.com,
 suzuki.poulose@arm.com, pbonzini@redhat.com, shuah@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: pbonzini@redhat.com, shuah@kernel.org
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

On Wed, 7 Apr 2021 15:59:37 +0200, Eric Auger wrote:
> Bring some improvements/rationalization over the first version
> of the vgic_init selftests:
> 
> - ucall_init is moved in run_cpu()
> - vcpu_args_set is not called as not needed
> - whenever a helper is supposed to succeed, call the non "_" version
> - helpers do not return -errno, instead errno is checked by the caller
> - vm_gic struct is used whenever possible, as well as vm_gic_destroy
> - _kvm_create_device takes an addition fd parameter

Applied to kvm-arm64/vgic-5.13, thanks!

[1/1] KVM: selftests: vgic_init kvm selftests fixup
      commit: 4cffb2df4260ed38c7ae4105f6913ad2d71a16ec

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
