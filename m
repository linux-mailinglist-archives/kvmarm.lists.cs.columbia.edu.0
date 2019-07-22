Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1B570214
	for <lists+kvmarm@lfdr.de>; Mon, 22 Jul 2019 16:18:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 320914A4F9;
	Mon, 22 Jul 2019 10:18:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linaro.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UDCa5YoFLuUh; Mon, 22 Jul 2019 10:18:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 838B44A534;
	Mon, 22 Jul 2019 10:18:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1A64E4A529
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Jul 2019 09:53:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cf+ixbWbrenW for <kvmarm@lists.cs.columbia.edu>;
 Mon, 22 Jul 2019 09:53:18 -0400 (EDT)
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 584674A524
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Jul 2019 09:53:18 -0400 (EDT)
Received: by mail-wr1-f68.google.com with SMTP id c2so36319799wrm.8
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Jul 2019 06:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4A+1IXOg0AUN44xOjU2IRxHAI7jKAe/Dsm+NufqoDwo=;
 b=h5xyyPGSNmBklwByUO/gVRTUPrqta7oP6slCL4V466Dk09LzZfaKpE38pxS8G5slhy
 kCEcqJytkJuTpeJ0ZkCmKFqCNrbEfC0lUXLQOENIXbxc4dFY4fY6/OIOFSzG/uq8Fa4v
 cVik26Hf7EfFjIME2gwYiHyFu/Ime6pzaPmIvGIuziJy56HmOJs6GrwoylHcUJ0SJiP+
 N4Zfu55ZuSuimc7A33dUu6HxUibxWLmeA1uTeG0hn89lx1ChoDQ/jvmIItGHJVSZKik4
 N3+eMf1E31OR4eP4wCFFWfiNFLlHmEP5mrxCgkR2Zr+NUHrxM7UvU9ht1gVrcWcerZak
 4A1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4A+1IXOg0AUN44xOjU2IRxHAI7jKAe/Dsm+NufqoDwo=;
 b=mcb6VH9UGokP7jTQcDMnL4GZhDa7ftyd4CoocGraVZ0VqEuEiOycfIJL00Oo2AeBaL
 oJHx4sqSbc9M6AGpfMQmuxpoulBmsUy1YAU0RUAXrjf/1mDxvSz70/dldfeDWW1cjAMP
 z7nwWPF0JRmIGT7CJqp3+yfPYTpR1UgQbA/gnLaWIQqtI0b94uO4WgzS/meaG8eW7gqO
 /iV/OVumxxSvZ38bOqZAByKWp+OuC9NYEFEpVb5caJdYFaDZmWlAkps0yA5pD2vkGfD5
 MtGt5QcHOVGO/0TuB4Lwz1SI9MnoFG+HYVHhBpmK+fyb21Pmil3dtZmJAE76yYBiWDKb
 /QlA==
X-Gm-Message-State: APjAAAV81Cqf0GTualkgFdgWzY+gfWmSopSZinoLWr179JfQg/m2nnXo
 eRmmJgZT7HYlm/rEpC4xzGHeYA==
X-Google-Smtp-Source: APXvYqywPiYMC6nufG0pkn9341YSKK0eKjFT1pvuf89bXzyjMLOex2BVhSg8UoynoCTGmuXI4lFN6w==
X-Received: by 2002:a5d:6650:: with SMTP id f16mr77388789wrw.89.1563803597410; 
 Mon, 22 Jul 2019 06:53:17 -0700 (PDT)
Received: from lophozonia.localdomain
 (cpc92304-cmbg19-2-0-cust820.5-4.cable.virginm.net. [82.24.199.53])
 by smtp.gmail.com with ESMTPSA id s10sm29821771wrt.49.2019.07.22.06.53.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 22 Jul 2019 06:53:16 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH] MAINTAINERS: Update my email address
Date: Mon, 22 Jul 2019 14:44:40 +0100
Message-Id: <20190722134438.31003-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 22 Jul 2019 10:18:34 -0400
Cc: virtio-dev@lists.oasis-open.org, lorenzo.pieralisi@arm.com, mst@redhat.com,
 linux-pci@vger.kernel.org, joro@8bytes.org, maz@kernel.org, will@kernel.org,
 kvmarm@lists.cs.columbia.edu
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

Update MAINTAINERS and .mailmap with my @linaro.org address, since I
don't have access to my @arm.com address anymore.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 0fef932de3db..8ce554b9c9f1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -98,6 +98,7 @@ Jason Gunthorpe <jgg@ziepe.ca> <jgunthorpe@obsidianresearch.com>
 Javi Merino <javi.merino@kernel.org> <javi.merino@arm.com>
 <javier@osg.samsung.com> <javier.martinez@collabora.co.uk>
 Jean Tourrilhes <jt@hpl.hp.com>
+<jean-philippe@linaro.org> <jean-philippe.brucker@arm.com>
 Jeff Garzik <jgarzik@pretzel.yyz.us>
 Jeff Layton <jlayton@kernel.org> <jlayton@redhat.com>
 Jeff Layton <jlayton@kernel.org> <jlayton@poochiereds.net>
diff --git a/MAINTAINERS b/MAINTAINERS
index 783569e3c4b4..bded78c84701 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17123,7 +17123,7 @@ F:	drivers/virtio/virtio_input.c
 F:	include/uapi/linux/virtio_input.h
 
 VIRTIO IOMMU DRIVER
-M:	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
+M:	Jean-Philippe Brucker <jean-philippe@linaro.org>
 L:	virtualization@lists.linux-foundation.org
 S:	Maintained
 F:	drivers/iommu/virtio-iommu.c
-- 
2.22.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
