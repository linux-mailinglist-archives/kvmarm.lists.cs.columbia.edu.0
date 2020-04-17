Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 608581ADF08
	for <lists+kvmarm@lfdr.de>; Fri, 17 Apr 2020 16:08:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E7CB14B175;
	Fri, 17 Apr 2020 10:08:28 -0400 (EDT)
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
	with ESMTP id zlasKPZeaVwE; Fri, 17 Apr 2020 10:08:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EF2784B1CC;
	Fri, 17 Apr 2020 10:08:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DB2BF4B139
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 10:08:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zgbrm9c8MJeS for <kvmarm@lists.cs.columbia.edu>;
 Fri, 17 Apr 2020 10:08:25 -0400 (EDT)
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com
 [209.85.221.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8FC304B109
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 10:08:25 -0400 (EDT)
Received: by mail-wr1-f73.google.com with SMTP id d17so1043917wrr.17
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 07:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=BE22UuNZU0lMhx6IeWqx8rVDm7BRVLiiw4JmHJTk0D4=;
 b=FqgGqdOBbcFZDrKICBx85vj7vmz84OnLAMXdYoF2drxsahvjwctT0humbUtm6uAyR1
 GZzWAH8y1eIGbYiSJwFrX67t0HgWpvUJzfuUrycXPjnYrnG/x/IYNiWe+Ln5IMd80zdP
 z8b367FA7hA8TR2LZhEWrXwGOsvB8pP1QE2puqADqePqaZlonimx3J6IPscuQeH93kAU
 OEaAw4uA19/rRZ9w7ssRxQZcTIoGx4e6nveSM3wS9T2luegSLtLHSIemCgbEmMLPT9vA
 ybAyXWHTBpqLWhwc8xibB6/RBHk+LTKKZEOPBoAUIvvGZ5ojAb2yE+Hj0YRxGknzAEHU
 3Nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=BE22UuNZU0lMhx6IeWqx8rVDm7BRVLiiw4JmHJTk0D4=;
 b=W0SPZVH4PoO4UviNTOpVr8l8HH94HLipYBzopM0BLaCfyeYlCy+Bs5WP2VGshnZ5+n
 LuUnNy6g3snAebrTa27scrPR9TFshO6c0t9QgCA68N/Nfv80KA7a/FlUMd/q6zunhVts
 uXcXx379Ku6qhNpLncHP3wnbfVQIMNOLhvasDAlmcvL50XfYx0LvdMjEjCfYJ0y+OR0A
 R4u8ALj+BPZZnmTMDkL92lznHB7mwolml27kNVDekP8acDArP4P9wdnDWuhQ5PwGnnwo
 1FQkSsiTAKGwyvzvQyqYr4TGVvhrZvb4D2xoqvagpIvJFkIsxPJaTooEDojgFBtelHzd
 0EGA==
X-Gm-Message-State: AGi0PubHQl1JImvvgITshlGuCIELw3NC7O8lqKElTqaCsEXIbNpDdz0W
 LJHCbussX1HknKBwJqn5USI5NIRR+w==
X-Google-Smtp-Source: APiQypKCZQGQ7DJihGmggqgsWgp8qGWUVhjdtkT5TYLBrVUIkIHTbtG7VV/zNKOKamGpegJHWQe+j+QxMA==
X-Received: by 2002:adf:ce02:: with SMTP id p2mr4047107wrn.173.1587132504324; 
 Fri, 17 Apr 2020 07:08:24 -0700 (PDT)
Date: Fri, 17 Apr 2020 15:08:17 +0100
Message-Id: <20200417140821.89974-1-tabba@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v3 0/4] KVM: arm64: Tidy up arch Kconfig and Makefiles
From: Fuad Tabba <tabba@google.com>
To: catalin.marinas@arm.com, maz@kernel.org, julien.thierry.kdev@gmail.com, 
 suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu
Cc: will@kernel.org
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

Hi,

This small patch series tidies up the arm64 KVM build system by
rejigging config options, removing some redundant help text, and
consolidating some of the Makefile rules.

The changes are cosmetic, but it seemed worthwhile to send this out
for consideration.  This set is rebased on top of [1], which moves
the (now arm64-specific) code.

Cheers,
/fuad

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm64/welcome-home

Fuad Tabba (1):
  KVM: arm64: Clean up kvm makefiles

Will Deacon (3):
  KVM: arm64: Kill off CONFIG_KVM_ARM_HOST
  KVM: arm64: Update help text
  KVM: arm64: Change CONFIG_KVM to a menuconfig entry

 arch/arm64/kernel/asm-offsets.c |  2 +-
 arch/arm64/kernel/smp.c         |  2 +-
 arch/arm64/kvm/Kconfig          | 22 ++++++++---------
 arch/arm64/kvm/Makefile         | 44 +++++++++++----------------------
 arch/arm64/kvm/hyp/Makefile     | 15 +++--------
 5 files changed, 31 insertions(+), 54 deletions(-)


base-commit: c9346fa274ada428631ded07eaba696cdf99ce4e
-- 
2.26.1.301.g55bc3eb7cb9-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
