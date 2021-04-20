Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A109D365CF3
	for <lists+kvmarm@lfdr.de>; Tue, 20 Apr 2021 18:13:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3F8234B381;
	Tue, 20 Apr 2021 12:13:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VybawIktmHAM; Tue, 20 Apr 2021 12:13:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8777A4B3D3;
	Tue, 20 Apr 2021 12:13:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1E4074B3CA
 for <kvmarm@lists.cs.columbia.edu>; Tue, 20 Apr 2021 12:13:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mSMI1hIjXx4l for <kvmarm@lists.cs.columbia.edu>;
 Tue, 20 Apr 2021 12:13:10 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A653B4B35A
 for <kvmarm@lists.cs.columbia.edu>; Tue, 20 Apr 2021 12:13:10 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1B751474;
 Tue, 20 Apr 2021 09:13:09 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BF7C3F73B;
 Tue, 20 Apr 2021 09:13:08 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: drjones@redhat.com,
	kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests RFC PATCH 0/1] configure: arm: Replace --vmm with
 --target
Date: Tue, 20 Apr 2021 17:13:37 +0100
Message-Id: <20210420161338.70914-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: pbonzini@redhat.com
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

This is an RFC because it's not exactly clear to me that this is the best
approach. I'm also open to using a different name for the new option, maybe
something like --platform if it makes more sense.

I see two use cases for the patch:

1. Using different files when compiling kvm-unit-tests to run as an EFI app
as opposed to a KVM guest (described in the commit message).

2. This is speculation on my part, but I can see extending
arm/unittests.cfg with a "target" test option which can be used to decide
which tests need to be run based on the configure --target value. For
example, migration tests don't make much sense on kvmtool, which doesn't
have migration support. Similarly, the micro-bench test doesn't make much
sense (to me, at least) as an EFI app. Of course, this is only useful if
there are automated scripts to run the tests under kvmtool or EFI, which
doesn't look likely at the moment, so I left it out of the commit message.

Using --vmm will trigger a warning. I was thinking about removing it entirely in
a about a year's time, but that's not set in stone. Note that qemu users
(probably the vast majority of people) will not be affected by this change as
long as they weren't setting --vmm explicitely to its default value of "qemu".

Alexandru Elisei (1):
  configure: arm: Replace --vmm with --target

 configure | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

-- 
2.31.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
