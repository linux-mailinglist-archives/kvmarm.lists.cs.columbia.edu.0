Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 378EC4207C4
	for <lists+kvmarm@lfdr.de>; Mon,  4 Oct 2021 11:03:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7292A4B264;
	Mon,  4 Oct 2021 05:03:45 -0400 (EDT)
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
	with ESMTP id VZs+OCb3OXXy; Mon,  4 Oct 2021 05:03:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 617C24B261;
	Mon,  4 Oct 2021 05:03:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 30E664B236
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 Oct 2021 05:03:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id if9e6Dh0vxaM for <kvmarm@lists.cs.columbia.edu>;
 Mon,  4 Oct 2021 05:03:41 -0400 (EDT)
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com
 [209.85.208.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 367B84B211
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 Oct 2021 05:03:41 -0400 (EDT)
Received: by mail-ed1-f74.google.com with SMTP id
 n19-20020a509353000000b003dad185759bso8586793eda.6
 for <kvmarm@lists.cs.columbia.edu>; Mon, 04 Oct 2021 02:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=YjTsD/0+blx8dzSzzvYPEmIwxWymL2rSsPmT9WrblMQ=;
 b=cDeVBbd8fmjR3GX4XwCizTRj0hWM50iHttru8PTyFUbxfI+Srq2N/f14A83cswDquw
 OE9TAuHD7lC8c+ic+i+yiOl6IQ6FAVHQZxmdzAY67B5j4gFWr8hZMA+WN6zXBqBp6NTN
 jgffafFQATGQHreUOq5eYQplEJ9eQJEWTkXjY37D/dAoaHfL9y81mvc9j/2KYhMfZYvq
 RdaZVd1Kr3Cd1Kg1HvlNAfRBfG/lGsC3tDKyTZS9O4kJQFviWp6aWFtCosLSaivreQ82
 eKsskutGnKtrjVhwwPVOhTRNgee+YZb0n732fTRei79zPf1IOd2rllBdb10/PIjLrgC6
 sr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=YjTsD/0+blx8dzSzzvYPEmIwxWymL2rSsPmT9WrblMQ=;
 b=qJTtYbxcMNmc6IUmbGM1jDEL4pLwYJrMuuU7AlEdgRXxVmIQe3SCT1VbZNjcOuDOOL
 RYoawZpNCGduw05DJgNdeIZdzvQLv+z+UPWTKuk+ygLg8fAHGcYqlXjL8U06z/gW2v3c
 fYFdX3ZlLnGK0p418t1WAYHF9xCZo7uhkRY6l4OzrNw12w70KBG2wfQ1KCwRfix6MgC8
 XPkouiQahafBxM1gZkjzOzZhj9O9fPNPOXpifBbJVDy7KESSi2i0KPw3aDyugTus2mOY
 9epoOKr4KmK5zHwO3jvnM6czvwjOFUqHFWxhqTuIuRt+nEMIcrr+xhfk6hlhHtDbnmoJ
 T6sw==
X-Gm-Message-State: AOAM533Ihsmq3+j1NUMN6Elcop1fRBGnDUZrnddNlaUQK2mPZqnufP53
 EDKNAa4LZmiwU4h0tLl/M9WWFodV8GL3
X-Google-Smtp-Source: ABdhPJwMBTgk+xzHhrOf7diiO6pKvFsFa+nBGQazRqVB1zzwDjDYGzDQkOsS9ibLYzZ2nicgVL/MVG58Ll6W
X-Received: from luke.lon.corp.google.com
 ([2a00:79e0:d:210:669b:5b16:60b7:a3d4])
 (user=qperret job=sendgmr) by 2002:a17:906:8281:: with SMTP id
 h1mr15169765ejx.352.1633338219898; Mon, 04 Oct 2021 02:03:39 -0700 (PDT)
Date: Mon,  4 Oct 2021 10:03:12 +0100
Message-Id: <20211004090328.540941-1-qperret@google.com>
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
