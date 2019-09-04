Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 673CAA9BAF
	for <lists+kvmarm@lfdr.de>; Thu,  5 Sep 2019 09:22:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DA0EC4A56C;
	Thu,  5 Sep 2019 03:22:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, FREEMAIL_FROM=0.001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@gmx.net
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HfYpkmS6iC3O; Thu,  5 Sep 2019 03:22:46 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8AA124A551;
	Thu,  5 Sep 2019 03:22:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5156A4A4C1
 for <kvmarm@lists.cs.columbia.edu>; Wed,  4 Sep 2019 14:08:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5fet6ipWo+uW for <kvmarm@lists.cs.columbia.edu>;
 Wed,  4 Sep 2019 14:08:02 -0400 (EDT)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 00C344A49F
 for <kvmarm@lists.cs.columbia.edu>; Wed,  4 Sep 2019 14:08:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1567620473;
 bh=uSFdeY18J73GEbur7/f5eGY33e2+gZfGIbg70oqM+2E=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=dFPK7v0eikK//IWvKaPDuTF8vPd9O/aKmO1DDSUY2K3IC2bxnVQ5PIk2EJhGM27kR
 +lY+G9BNhgaiYDLaUrJX9F/2f1aIQsTNuq3ya5rD0AT7g8CjigqFQwromeihBXHSXC
 O/uuMoGto9MJPLXCEM44QVkN4nCV3sTM8MJWrjW4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([84.118.159.3]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MhlGk-1ij1B310yG-00dqYX; Wed, 04 Sep 2019 20:07:53 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 1/1] KVM: inject data abort if instruction cannot be decoded
Date: Wed,  4 Sep 2019 20:07:36 +0200
Message-Id: <20190904180736.29009-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
X-Provags-ID: V03:K1:abXNHvOQi/p7CEIzoPWMQ9XFYpp4Z25ZscYRNbtDcb67ZH0vqAE
 CCaWYLtBMzVUoZZj3DLLIFWRozpR+tYvr63KEw05ujxgzzI7iN0g+dgjei45TpxWlugdsiF
 hLqcNFs7qc6B5xKFTZBxgoGdWkp6vsuL+qhmsf9GozxhZ5IUyUHXZk7+SsU37eCbQpoyn4O
 c/fcxp1MYFQRPvj2y1OVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JozR6u9JImk=:9BlOOIijgEVJQxytK0x9tx
 ffPR1NDnISmrIyzczzP11cywtaAFP9aCT0RxToSFNkToJSnm4aAHE/S7sSOhgAIyxz/MiIr75
 KcPkdb6fnx23AA/KWNlaSRurYgMgazJ/6IuexrQBTdxaFm90ZlBzRLL3K8ywN/CV7JZtvH6z7
 aFhqnENeGY04kiL4Zvg4gvZ4OW0XCYjI/FqU9AbtXKdBObedSvwR72zNEd05U37t9+x8zKk6j
 LTJizGn7PHI8EuNOQLdKg0IXFjG8dPDYe8z7wgn2qlKGBjBeAawjfNp3Epb6kUw9213ZNGLMo
 fh1gBhdrooRdaj1tEiGAhterenwoPCIM9X+VRYi8DAQbb70yGSicPAYEljE/k+/rJofxOuT+q
 CxwkoHsuZ4mqi5+NhnaTJl4e36SNg28WzHRxDYOvL2igXBERcU6bsBTitDCccbufyP+5dPxOQ
 uPyjZfdAVfzt20K85FboUwnZkpWJ8PAiIrQaJZXInThEl1hlhcQZBHzYzyhU5Hr0vT7U4bguC
 Jk1d4iShpWENsqgl5/YyR1EpmrUUZyiBRo01uDGlt9hLy/RC6f3F7rSjihjY1zPvYJb9r26zl
 sjKm0HwdyniWypblwzX1tidPLcBPHVc7xLlAQB9Amxfrap8J5aIaJV9ncupkKh9lDp1SMA7bi
 bbFb7ydvnEj9BvWA7m7P9G3rJBACZN+IByS9r2paS2gmJORze++SF7xMJ4CapGqMPhm0Uh0+m
 NWRh4c0s58AB0LRR0FnqR0vIkZjw58tSrhrZpQ+i3HGvS9U73dI9u74NpBU/UtPNAl1M2oC33
 lU0fo9l6DRWSvRYhpvM+2DLbV2udzosMeRZaicEkLQuVPBWNFtqfE6GjW4KVEbg3EftIIKjKR
 0gT3EfIIZdht5LApSOvcoT70CR06LPLNQ0o3DEzr2ake3RZ2x6ItWyyJD2cf+MIMsBa7xKluS
 cRnSMqgtb9PkRlVbNFar+V/OJ3yKgF04Ay4K/3PiP3AygXGBXLaN2SaDOnbm+6BsN8XXZNLGJ
 wEJbpsOVJ8RM0sLV8X2HpOgJy77cP3gLkngJ3OQ0+ziAetElq+4QoVGQHvzzIc37WuWuUj672
 HV4zT7/BsxTmuoCUoNd2qwOf/vWbcWNHRuTTY+ujEDs0+SybO+LhCZ8r+WlBFZgejj7NXq+RE
 cgxieGDxbNjHstwJ68ra7rk37gfXEY/CDV3xk1cGtH89pLOT4mYhLPJ/CAin64ctNsznLUIXM
 81exZsNAov/vsxqph
X-Mailman-Approved-At: Thu, 05 Sep 2019 03:22:44 -0400
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

If an application tries to access memory that is not mapped, an error
ENOSYS, "load/store instruction decoding not implemented" may occur.
QEMU will hang with a register dump.

Instead create a data abort that can be handled gracefully by the
application running in the virtual environment.

Now the virtual machine can react to the event in the most appropriate
way - by recovering, by writing an informative log, or by rebooting.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 virt/kvm/arm/mmio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/mmio.c b/virt/kvm/arm/mmio.c
index a8a6a0c883f1..0cbed7d6a0f4 100644
--- a/virt/kvm/arm/mmio.c
+++ b/virt/kvm/arm/mmio.c
@@ -161,8 +161,8 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		if (ret)
 			return ret;
 	} else {
-		kvm_err("load/store instruction decoding not implemented\n");
-		return -ENOSYS;
+		kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
+		return 1;
 	}

 	rt = vcpu->arch.mmio_decode.rt;
--
2.23.0.rc1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
