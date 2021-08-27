Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 64A143F97EA
	for <lists+kvmarm@lfdr.de>; Fri, 27 Aug 2021 12:16:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C91C04B11C;
	Fri, 27 Aug 2021 06:16:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SIsDu-YqH5-T; Fri, 27 Aug 2021 06:16:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B2B884B130;
	Fri, 27 Aug 2021 06:16:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 13A754B10C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Aug 2021 06:16:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jNrJ852zePjE for <kvmarm@lists.cs.columbia.edu>;
 Fri, 27 Aug 2021 06:16:16 -0400 (EDT)
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com
 [209.85.222.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3B2E14B10B
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Aug 2021 06:16:16 -0400 (EDT)
Received: by mail-qk1-f201.google.com with SMTP id
 62-20020a3706410000b02903d2cdd9acf0so5362385qkg.21
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Aug 2021 03:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=KX8dWkVT+7qp2o5wgzztnL/TjK4rsIbskb1FytAuhHQ=;
 b=IIOfuk/8nIQZSSjOcxde0I6sd1i3XbS/k4mpqYXVxXZs7bIPMgKrNkS3KWZcguE5eQ
 0Fa27eJ+SO0liN88PqhjvNhLct4wCDiroSiV9TFlHhQuFJrEv4ulviWgZPk8CT9Pumpm
 BJJ4iNC7UiJYT8tmQl2ni41OY6GsMh33R0FDK0wxiAHLd66DLL0sPupulyxZnDj4DE2s
 d68YtA5/ntycpLiPXcuQOKAhzEYo+IpYowcw8YXlYfVx0MrIUUJ6r7SIxGCSRWKk1w7D
 mnVKku6jOaNaSG4YMod+1f7XSvyDY9dmx0UdR1E9S/gV7xh9Vq63ZGTsq/oN8ETXelrl
 71RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=KX8dWkVT+7qp2o5wgzztnL/TjK4rsIbskb1FytAuhHQ=;
 b=YDXMzEyOno4h5uB6KTIBjd5B6yMh0bm/8Y6sg9h5Z4IlYrYDKVnoSXdQguuisTtyGA
 JM89Wan7VvtVkiOII1Czko71SbMUl1MxYVM+Olb5Fv92eTjg2AyZKmjaNlqGZGx9nhuq
 blTy3kBYar8tYuz2CBiAAW2jkkrSILDcXfXHOIo5aBsBNbFCyN0fjFCjv73Z1ebJ1qMm
 MPa7zUxllyqo0tshM5Sf4wM5N6MDafTkjXEoLm/Ls4PQI/src48ICxcTcjU8+fZ3zrGt
 +duN/zY0gwMHLLkn8Ot4pbtfTzi9wFjig8UuJ7iyoghbWnPmjgnwdHy6jy9g1kbAZt7P
 DGLQ==
X-Gm-Message-State: AOAM5310M/F/VBmdiD8SsK/ks9GxebHfM+8lvJRKW/0/3ZCWPc3c0JXc
 POF7bzrR2zjfVPZyAacxHBngoczc58FOS90aH9PIkeGGN3PuZIhQa5CTgF53qNQCP4gEgvDSRBE
 xaxS9u8vipOhMBkzNhENTqnvign2QrgvDH9C3faoaZu31rNDNm6bteXSxZ300QqDTNHI=
X-Google-Smtp-Source: ABdhPJyLOQHqGi7X3qrRZ3x7KXpEc+43eQb9QgrNWhLDvOaIysfhOoD6wUPEKMylthJrErCd+rKMH1n+Og==
X-Received: from tabba.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:482])
 (user=tabba job=sendgmr) by 2002:a0c:e803:: with SMTP id
 y3mr9071549qvn.39.1630059375607; 
 Fri, 27 Aug 2021 03:16:15 -0700 (PDT)
Date: Fri, 27 Aug 2021 11:16:03 +0100
In-Reply-To: <20210827101609.2808181-1-tabba@google.com>
Message-Id: <20210827101609.2808181-3-tabba@google.com>
Mime-Version: 1.0
References: <20210827101609.2808181-1-tabba@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH v5 2/8] KVM: arm64: Add missing field descriptor for MDCR_EL2
From: Fuad Tabba <tabba@google.com>
To: kvmarm@lists.cs.columbia.edu
Cc: kernel-team@android.com, kvm@vger.kernel.org, maz@kernel.org,
 pbonzini@redhat.com, will@kernel.org, linux-arm-kernel@lists.infradead.org
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

It's not currently used. Added for completeness.

No functional change intended.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/include/asm/kvm_arm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 327120c0089f..a39fcf318c77 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -295,6 +295,7 @@
 #define MDCR_EL2_HPMFZO		(UL(1) << 29)
 #define MDCR_EL2_MTPME		(UL(1) << 28)
 #define MDCR_EL2_TDCC		(UL(1) << 27)
+#define MDCR_EL2_HLP		(UL(1) << 26)
 #define MDCR_EL2_HCCD		(UL(1) << 23)
 #define MDCR_EL2_TTRF		(UL(1) << 19)
 #define MDCR_EL2_HPMD		(UL(1) << 17)
-- 
2.33.0.259.gc128427fd7-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
