Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D3E82272497
	for <lists+kvmarm@lfdr.de>; Mon, 21 Sep 2020 15:08:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6BF3A4B5B4;
	Mon, 21 Sep 2020 09:08:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JXRX4Ex8w3p0; Mon, 21 Sep 2020 09:08:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 700AD4B5B9;
	Mon, 21 Sep 2020 09:07:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BB10C4B4B7
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Sep 2020 09:07:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WbxlnZSVVhmq for <kvmarm@lists.cs.columbia.edu>;
 Mon, 21 Sep 2020 09:07:57 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B7B904B377
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Sep 2020 09:07:57 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12EE4D6E;
 Mon, 21 Sep 2020 06:07:57 -0700 (PDT)
Received: from monolith.localdoman (unknown [10.37.8.129])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 842D73F73B;
 Mon, 21 Sep 2020 06:07:55 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH 0/2] KVM: arm64: Documentation updates
Date: Mon, 21 Sep 2020 14:08:36 +0100
Message-Id: <20200921130838.37296-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Cc: maz@kernel.org
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

I noticed some discrepancies between the error codes returned by KVM PMU
emulation and the documentation, this is my attempt at fixing them.

The code is from the original implementation of KVM PMU, and I thought it
would be more prudent to modify the documentation to match the code instead
of the other way around.

Alexandru Elisei (2):
  KVM: arm64: Add undocumented return values for PMU device control
    group
  KVM: arm64: Match PMU error code descriptions with error conditions

 Documentation/virt/kvm/devices/vcpu.rst | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.28.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
