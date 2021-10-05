Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B60F6422192
	for <lists+kvmarm@lfdr.de>; Tue,  5 Oct 2021 11:02:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3C8D44B2EB;
	Tue,  5 Oct 2021 05:02:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lrhysLKd2y4b; Tue,  5 Oct 2021 05:02:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 34CFB4B2DF;
	Tue,  5 Oct 2021 05:02:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E2F224B2A7
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 Oct 2021 05:02:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XG2J9by3fua1 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  5 Oct 2021 05:02:02 -0400 (EDT)
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com
 [209.85.219.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D627D4B270
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 Oct 2021 05:02:02 -0400 (EDT)
Received: by mail-qv1-f73.google.com with SMTP id
 u13-20020ad45aad000000b003829b9760b8so13309910qvg.18
 for <kvmarm@lists.cs.columbia.edu>; Tue, 05 Oct 2021 02:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=YjTsD/0+blx8dzSzzvYPEmIwxWymL2rSsPmT9WrblMQ=;
 b=Oni8vTpzdoAguLL9g/0bTNlxG6eqPKNXR7hlH2QVhmPG/MSICPVMmjIkLRMVoFZsak
 qu7HwsUXwfWdDGja/pJ6rr0gubuHFEcEDOhT1sEUrKFT0YEeebrwEK01Eukybn0GEJ7t
 Un/N37PDtmLGAevXkQx9RIeDEMjoS/Rb6BKBU4YVPFU/ad/YLq/KXkFDoCP+IObdA6h4
 kfqOcbJ1Axh78XlOffdWVzqd2+p5AV42WHmazyMlMQLbiNF3gOWDEbO9ZaI5Y5tsmZct
 qU/XyCEcLAj+ar44gtcChNSpXGDU2wR5b0HWyYCQDMIYY+/le0bK+7smskmSqoCjAFra
 8DDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=YjTsD/0+blx8dzSzzvYPEmIwxWymL2rSsPmT9WrblMQ=;
 b=SOnEMAz1cMDJvLqq+HoI9Vf2T7dWPLa+vtTvk/EwrYBDHBhxtyUG205pyVNbieO/cT
 3TeUsgkUmMPOFZfXlv9q38gv/chVPLdwRB1z9rFzRQ5GF0puazckDm/cQrEqYzQH0Tep
 l61L0yEf8/qYpK3v/n/6PunQ8+npKEzePl9+xva34KkWVb/5z4kvVWoxog0mZoRsN89b
 Ki75CP5WOxE4ulRNkA7w3tWTKQMgvrfk372I/j4WalevKTh7iJnB3kYF87J7RMnZ1Xwa
 DRJ18gQOOOiVFsJx9Gef4gWQgJCAVmj7aDaXqcWrNwtRA/aWChIFM9WrftGU+gfgZmCi
 1/fA==
X-Gm-Message-State: AOAM532wcggG1cZqOlPWQfNWgI1FifUo9EyGs0QP7lEs69zIRmLAWZi1
 5ca1QCBAoufGVU67NEGdlTorb2sOX5Xe
X-Google-Smtp-Source: ABdhPJzdJwotAoaBB3EtyGIAZNxFrytEsAJXsOE9DPlOSjQixLdLb9VSyUZ6rGK2FOH7gAKnzLzBgNvtbGus
X-Received: from luke.lon.corp.google.com
 ([2a00:79e0:d:210:5700:9128:3106:b389])
 (user=qperret job=sendgmr) by 2002:ad4:4629:: with SMTP id
 x9mr26087544qvv.58.1633424522389; Tue, 05 Oct 2021 02:02:02 -0700 (PDT)
Date: Tue,  5 Oct 2021 10:01:37 +0100
Message-Id: <20211005090155.734578-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH 0/2] A couple of EL2 refcounts fixes
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Quentin Perret <qperret@google.com>, Fuad Tabba <tabba@google.com>, 
 David Brazdil <dbrazdil@google.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
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

Hi all,

This addresses a couple of issues Will has found with the refcounting of
page-tables at EL2. Patch 01 fixes a nasty bug, and probably wants to go
in -stable. Patch 02 fixes a small inconsistency which made it harder to
find refcount-related bugs at EL2.

Feedback welcome !

Thanks,
Quentin

Quentin Perret (2):
  KVM: arm64: Fix host stage-2 PGD refcount
  KVM: arm64: Report corrupted refcount at EL2

 arch/arm64/kvm/hyp/include/nvhe/gfp.h |  1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c |  6 +++++-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c  | 15 +++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.33.0.800.g4c38ced690-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
