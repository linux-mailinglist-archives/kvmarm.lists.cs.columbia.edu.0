Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED1C492AFD
	for <lists+kvmarm@lfdr.de>; Tue, 18 Jan 2022 17:18:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 76B5640C2B;
	Tue, 18 Jan 2022 11:18:37 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.8
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W9B9X2ETt8LD; Tue, 18 Jan 2022 11:18:37 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 23E1A4101F;
	Tue, 18 Jan 2022 11:18:36 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BCFA440C2B
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Jan 2022 11:18:35 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YHtCGKKBx7w8 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 18 Jan 2022 11:18:34 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E73E40B8F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Jan 2022 11:18:34 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90C001FB;
 Tue, 18 Jan 2022 08:18:33 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFC523F774;
 Tue, 18 Jan 2022 08:18:31 -0800 (PST)
Date: Tue, 18 Jan 2022 16:18:40 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: pbonzini@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 imbrenda@linux.ibm.com, david@redhat.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org,
 linux-s390@vger.kernel.org
Subject: [kvm-unit-tests] Permitted license for new library
Message-ID: <YeboYFQQtuQH1+Rf@monolith.localdoman>
MIME-Version: 1.0
Content-Disposition: inline
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

Hello,

I would like to know what licenses are permitted when adding a new library
to kvm-unit-tests (similar to libfdt). Is it enough if the library is
licensed under one of the GPLv2 compatible licenses [1] or are certain
licenses from that list not accepted for kvm-unit-tests?

[1] https://www.gnu.org/licenses/license-list.html#GPLCompatibleLicenses

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
