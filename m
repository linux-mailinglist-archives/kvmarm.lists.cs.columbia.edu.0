Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 782B051218F
	for <lists+kvmarm@lfdr.de>; Wed, 27 Apr 2022 20:48:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2A45F4B206;
	Wed, 27 Apr 2022 14:48:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sIUJdRvTGQMf; Wed, 27 Apr 2022 14:48:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B6B5849EBE;
	Wed, 27 Apr 2022 14:48:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B33B49EBE
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 Apr 2022 14:48:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O-kVvjsr1HGS for <kvmarm@lists.cs.columbia.edu>;
 Wed, 27 Apr 2022 14:48:19 -0400 (EDT)
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com
 [209.85.128.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id ECEB7408F4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 Apr 2022 14:48:18 -0400 (EDT)
Received: by mail-yw1-f202.google.com with SMTP id
 00721157ae682-2f7c5767f0fso24511807b3.4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 Apr 2022 11:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=qw1fLdybZ6hBEq+K27NOvzBDWEAj2E1C7sSKlxfguSQ=;
 b=cfd04UhRCBsCWf6c4bPi6x+8MQaNk/olBhTtBbTpqCiQ2BWVcZ6NhjtgF7AnIgTTUi
 ceKEwr9VxXRR74zwA+g9ZYawgkbbJahVtdKD0KKfuJGooAUtTur4hig7MWIEHRRCxEnF
 XIkrt87dmx5nEE2z0el2BN7ZRD42oej7A89SsoWkNaAbuJHLCrwJx7MHztgSS/eOxLeX
 KY4212FfHSAazBf1RJhU9yt/64pBPcQL2ohAMBLrlshtnWybl4Uo5P+rptBPOxUu0B0a
 f9sQ7BMRudCASdt2qZm3vxmXC1eLxIF5XRhaBWkaBX6Y+49/6p0YCPhvrniXX5ZK+0ej
 Wp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=qw1fLdybZ6hBEq+K27NOvzBDWEAj2E1C7sSKlxfguSQ=;
 b=2gq/Mc+onXIlz4w41XVvc5tf5WB2cTClfqspQwd3/DaXDEScq47/pxNOkgnOc6VFcI
 j0Et9EEDK+WccqC+NbwBLdLlpmrM5WW74euaYbvG9/YlL3aJVFBSzaltijpXvRPLunfj
 yMlyjDnhlDD4RBann6D+2Ur5PVOMfrUlXjuh/J9iFchB5qyiliQDBytF9jcjgHMVyf9b
 QrLAuJ4Izwpy6QM6v4xZKjgTTGi3ewruZD3eSnKp1o4ELAe8U/QsSXhCFL/SAzik63SG
 XP1bPXosq0cSlg3wXF6ge5deNlPR/YR8oMmwXNvj4zDW5gxXWoxm9eYs230Vi82V24jS
 Bg0Q==
X-Gm-Message-State: AOAM532mvLIo9Tdm4eszB31OQfFjY3E1h0609wf+sDA4ZrLfMPWNjoKj
 kz9XkCRANZPhnOGph5UWvWyqIKhSf0u4rw==
X-Google-Smtp-Source: ABdhPJx5HPurZaW7U8sJSRlYHIdCXhy0xV5nUG4epB8G0SMn2J2JcIpwjEHrwh/hKhlOFf2L1QaJUZM4zdW3ww==
X-Received: from ricarkol2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:62fe])
 (user=ricarkol job=sendgmr) by 2002:a25:928e:0:b0:633:f370:d9ff with SMTP id
 y14-20020a25928e000000b00633f370d9ffmr26953261ybl.338.1651085298506; Wed, 27
 Apr 2022 11:48:18 -0700 (PDT)
Date: Wed, 27 Apr 2022 11:48:11 -0700
In-Reply-To: <20220427184814.2204513-1-ricarkol@google.com>
Message-Id: <20220427184814.2204513-2-ricarkol@google.com>
Mime-Version: 1.0
References: <20220427184814.2204513-1-ricarkol@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v2 1/4] KVM: arm64: vgic: Check that new ITEs could be saved
 in guest memory
From: Ricardo Koller <ricarkol@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: andre.przywara@arm.com, pshier@google.com, maz@kernel.org,
 pbonzini@redhat.com
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

Try to improve the predictability of ITS save/restores by failing
commands that would lead to failed saves. More specifically, fail any
command that adds an entry into an ITS table that is not in guest
memory, which would otherwise lead to a failed ITS save ioctl. There
are already checks for collection and device entries, but not for
ITEs.  Add the corresponding check for the ITT when adding ITEs.

Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/arm64/kvm/vgic/vgic-its.c | 51 ++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 2e13402be3bd..e14790750958 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -894,6 +894,18 @@ static int vgic_its_cmd_handle_movi(struct kvm *kvm, struct vgic_its *its,
 	return update_affinity(ite->irq, vcpu);
 }
 
+static bool __is_visible_gfn_locked(struct vgic_its *its, gpa_t gpa)
+{
+	gfn_t gfn = gpa >> PAGE_SHIFT;
+	int idx;
+	bool ret;
+
+	idx = srcu_read_lock(&its->dev->kvm->srcu);
+	ret = kvm_is_visible_gfn(its->dev->kvm, gfn);
+	srcu_read_unlock(&its->dev->kvm->srcu, idx);
+	return ret;
+}
+
 /*
  * Check whether an ID can be stored into the corresponding guest table.
  * For a direct table this is pretty easy, but gets a bit nasty for
@@ -908,9 +920,7 @@ static bool vgic_its_check_id(struct vgic_its *its, u64 baser, u32 id,
 	u64 indirect_ptr, type = GITS_BASER_TYPE(baser);
 	phys_addr_t base = GITS_BASER_ADDR_48_to_52(baser);
 	int esz = GITS_BASER_ENTRY_SIZE(baser);
-	int index, idx;
-	gfn_t gfn;
-	bool ret;
+	int index;
 
 	switch (type) {
 	case GITS_BASER_TYPE_DEVICE:
@@ -933,12 +943,11 @@ static bool vgic_its_check_id(struct vgic_its *its, u64 baser, u32 id,
 			return false;
 
 		addr = base + id * esz;
-		gfn = addr >> PAGE_SHIFT;
 
 		if (eaddr)
 			*eaddr = addr;
 
-		goto out;
+		return __is_visible_gfn_locked(its, addr);
 	}
 
 	/* calculate and check the index into the 1st level */
@@ -964,16 +973,30 @@ static bool vgic_its_check_id(struct vgic_its *its, u64 baser, u32 id,
 	/* Find the address of the actual entry */
 	index = id % (SZ_64K / esz);
 	indirect_ptr += index * esz;
-	gfn = indirect_ptr >> PAGE_SHIFT;
 
 	if (eaddr)
 		*eaddr = indirect_ptr;
 
-out:
-	idx = srcu_read_lock(&its->dev->kvm->srcu);
-	ret = kvm_is_visible_gfn(its->dev->kvm, gfn);
-	srcu_read_unlock(&its->dev->kvm->srcu, idx);
-	return ret;
+	return __is_visible_gfn_locked(its, indirect_ptr);
+}
+
+/*
+ * Check whether an event ID can be stored in the corresponding Interrupt
+ * Translation Table, which starts at device->itt_addr.
+ */
+static bool vgic_its_check_event_id(struct vgic_its *its, struct its_device *device,
+		u32 event_id)
+{
+	const struct vgic_its_abi *abi = vgic_its_get_abi(its);
+	int ite_esz = abi->ite_esz;
+	gpa_t gpa;
+
+	/* max table size is: BIT_ULL(device->num_eventid_bits) * ite_esz */
+	if (event_id >= BIT_ULL(device->num_eventid_bits))
+		return false;
+
+	gpa = device->itt_addr + event_id * ite_esz;
+	return __is_visible_gfn_locked(its, gpa);
 }
 
 static int vgic_its_alloc_collection(struct vgic_its *its,
@@ -1061,9 +1084,6 @@ static int vgic_its_cmd_handle_mapi(struct kvm *kvm, struct vgic_its *its,
 	if (!device)
 		return E_ITS_MAPTI_UNMAPPED_DEVICE;
 
-	if (event_id >= BIT_ULL(device->num_eventid_bits))
-		return E_ITS_MAPTI_ID_OOR;
-
 	if (its_cmd_get_command(its_cmd) == GITS_CMD_MAPTI)
 		lpi_nr = its_cmd_get_physical_id(its_cmd);
 	else
@@ -1076,6 +1096,9 @@ static int vgic_its_cmd_handle_mapi(struct kvm *kvm, struct vgic_its *its,
 	if (find_ite(its, device_id, event_id))
 		return 0;
 
+	if (!vgic_its_check_event_id(its, device, event_id))
+		return E_ITS_MAPTI_ID_OOR;
+
 	collection = find_collection(its, coll_id);
 	if (!collection) {
 		int ret = vgic_its_alloc_collection(its, &collection, coll_id);
-- 
2.36.0.464.gb9c8b46e94-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
