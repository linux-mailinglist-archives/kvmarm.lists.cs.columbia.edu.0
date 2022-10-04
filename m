Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 783A45F4A9B
	for <lists+kvmarm@lfdr.de>; Tue,  4 Oct 2022 23:02:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9B76543C96;
	Tue,  4 Oct 2022 17:02:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Status: No, score=-1.79 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KqOAqlanSBwc; Tue,  4 Oct 2022 17:02:54 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3CD9843482;
	Tue,  4 Oct 2022 17:02:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 04A1B43479
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Oct 2022 17:02:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cltmLFecNt31 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  4 Oct 2022 17:02:50 -0400 (EDT)
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 982A24040B
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Oct 2022 17:02:50 -0400 (EDT)
Date: Tue, 4 Oct 2022 21:02:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1664917369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=ZZPNPYzSVNBZuhnGB7CrCaQRRGaAvl+BMTJQ2z40OX0=;
 b=lNRjK2gvnV2+LQrnimaTqv2eY7/OBYwVSyLWUrjWNP6Ezl1kVhSJW1hOjl72cjEngiHhx4
 R1YdpsVkyvRMGPH1j6jssUyE0XuHysQ7bNmcA76PJFjJXCSAOuGVX6Vuo8JigZagfYRwN/
 5/CjJHfZqneXs66O33qwXrMToAJnw+g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: pbonzini@redhat.com
Subject: arm64 build failure on kvm/next
Message-ID: <YzyfcIyudmSzTKx/@google.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT
Cc: kvmarm@lists.linux.dev, maz@kernel.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
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

Hey Paolo,

Just wanted to give you a heads up about a build failure on kvm/next.
Marc pulled some of the sysreg refactoring updates from core arm64 to
resolve a conflict, which resulted in:

drivers/perf/arm_spe_pmu.c:677:7: error: use of undeclared identifier 'ID_AA64DFR0_PMSVER_8_2'
        case ID_AA64DFR0_PMSVER_8_2:
             ^
drivers/perf/arm_spe_pmu.c:679:7: error: use of undeclared identifier 'ID_AA64DFR0_PMSVER_8_3'
        case ID_AA64DFR0_PMSVER_8_3:
             ^
drivers/perf/arm_spe_pmu.c:961:10: error: use of undeclared identifier 'ID_AA64DFR0_PMSVER_SHIFT'
                                                   ID_AA64DFR0_PMSVER_SHIFT);

The fix has since gone in on the arm64 side [1], in case you want to
mention in your pull request.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/sysreg&id=db74cd6337d2691ea932e36b84683090f0712ec1

--
Thanks,
Oliver
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
