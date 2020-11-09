Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C25512AB6DC
	for <lists+kvmarm@lfdr.de>; Mon,  9 Nov 2020 12:32:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 716D04B74A;
	Mon,  9 Nov 2020 06:32:48 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pJq0+-r1T6kp; Mon,  9 Nov 2020 06:32:47 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4CDE24B743;
	Mon,  9 Nov 2020 06:32:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4F1E94B741
 for <kvmarm@lists.cs.columbia.edu>; Mon,  9 Nov 2020 06:32:46 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dt4YYdPktzTx for <kvmarm@lists.cs.columbia.edu>;
 Mon,  9 Nov 2020 06:32:45 -0500 (EST)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3811F4B759
 for <kvmarm@lists.cs.columbia.edu>; Mon,  9 Nov 2020 06:32:45 -0500 (EST)
Received: by mail-wm1-f65.google.com with SMTP id h2so7655908wmm.0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 09 Nov 2020 03:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f226i52yIUjNH4HBJOMzOEDrBWriDTS35aJrFSCy+Ic=;
 b=tKDv7a9REysuwMcfZXBWv7HtDLUfJLSTc25Wz4yG+dYB9FiY+ZSpS20+jeI7ruPf4I
 /fRs+zUVAIUMH1v15ddDDay1fvfPcrhZMC5kpfB1XWwITdN/8S2pMA+But30yQSNFNB8
 jXgP2h4bzV7gV3d+faa8zOcxytIQ75QP4e6KxzkSUI0fLT1OOhTj4AvNRjPQ6XdKxesG
 ND6CsW+tx1PrW/9Sz/H3LHqnbchMyHOUycxmZIOc1N/2GLN4ul752VNg35nnWTjEXdVH
 EK3JO5SzqaS0OeDrJpetOM5SGKT+6ZRfLDHKcoyYlwBds01zZYnphO02pxAGc+J+wzvK
 hRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=f226i52yIUjNH4HBJOMzOEDrBWriDTS35aJrFSCy+Ic=;
 b=nWjiltfYwMSNCpU3ztfuCiuLmKSeiM61isC4UUXSwKEqlQujwx3nLFkFa0J+1HQeAO
 Q44fYewWKP522QWVjgt0j4HGHtZyDWsPLvhcDKclULwAPjHmvL4j5aZiEnzncdCJz+Jb
 Ako8EgCtEQu/uDCzlshJsMMw7U2FamdCHg+drb5CMp3P5Vsf6XpK54JsWN0HREJhPcJi
 2A+J1FqZ+VFOvANNbuoUFz58VisXwIDVJxkprlBFRH+Ke3pm+JFbmXpOm3d7lJeQC/Pp
 1Jt0Mo2aZiroPJ/7+Ed0DQRCK6C2MtjGiwA24jtKBWapwFhXjDq5hnP+v9tw5qCn+IgF
 DuFw==
X-Gm-Message-State: AOAM532qtmOeMqXYFv+Np7E4j75/kPLwWIZAHRDpROZ/M2Jk4ra6QOPy
 QvXLGXa5XwXE4gVqntqK5rKxuRz44MIJZYm3
X-Google-Smtp-Source: ABdhPJwoENuVGCK5XFTaDJ8MaIk0VaZFOfs2tSaTvsARZ9sJi9l+ITqvhV3gCNpUzPG+TP47XhXsRw==
X-Received: by 2002:a1c:7dc8:: with SMTP id
 y191mr14412755wmc.118.1604921563823; 
 Mon, 09 Nov 2020 03:32:43 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:209d:10b7:c480:3e1f])
 by smtp.gmail.com with ESMTPSA id h4sm12847197wrp.52.2020.11.09.03.32.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 03:32:42 -0800 (PST)
From: David Brazdil <dbrazdil@google.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v1 02/24] psci: Accessor for configured PSCI function IDs
Date: Mon,  9 Nov 2020 11:32:11 +0000
Message-Id: <20201109113233.9012-3-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
MIME-Version: 1.0
Cc: kernel-team@android.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Andrew Walbran <qwandor@google.com>, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Tejun Heo <tj@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Christoph Lameter <cl@linux.com>,
 Will Deacon <will@kernel.org>
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

Function IDs used by PSCI are configurable for v0.1 via DT/APCI. If the
host is using PSCI v0.1, KVM's host PSCI proxy needs to use the same IDs.
Expose the array holding the information with a read-only accessor.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 drivers/firmware/psci/psci.c | 14 ++++++--------
 include/linux/psci.h         | 10 ++++++++++
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index bc1b2d60fdbf..b67b2ba8a084 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -65,16 +65,14 @@ typedef unsigned long (psci_fn)(unsigned long, unsigned long,
 				unsigned long, unsigned long);
 static psci_fn *invoke_psci_fn;
 
-enum psci_function {
-	PSCI_FN_CPU_SUSPEND,
-	PSCI_FN_CPU_ON,
-	PSCI_FN_CPU_OFF,
-	PSCI_FN_MIGRATE,
-	PSCI_FN_MAX,
-};
-
 static u32 psci_function_id[PSCI_FN_MAX];
 
+u32 psci_get_function_id(enum psci_function fn)
+{
+	WARN_ON(fn >= PSCI_FN_MAX);
+	return psci_function_id[fn];
+}
+
 #define PSCI_0_2_POWER_STATE_MASK		\
 				(PSCI_0_2_POWER_STATE_ID_MASK | \
 				PSCI_0_2_POWER_STATE_TYPE_MASK | \
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 5b5dcf176aa6..8fe681a7b43d 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -29,6 +29,16 @@ bool psci_has_osi_support(void);
  */
 int psci_driver_version(void);
 
+enum psci_function {
+	PSCI_FN_CPU_SUSPEND,
+	PSCI_FN_CPU_ON,
+	PSCI_FN_CPU_OFF,
+	PSCI_FN_MIGRATE,
+	PSCI_FN_MAX,
+};
+
+u32 psci_get_function_id(enum psci_function fn);
+
 struct psci_operations {
 	u32 (*get_version)(void);
 	int (*cpu_suspend)(u32 state, unsigned long entry_point);
-- 
2.29.2.222.g5d2a92d10f8-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
