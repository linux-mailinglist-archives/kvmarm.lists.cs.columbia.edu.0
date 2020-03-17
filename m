Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E4799188614
	for <lists+kvmarm@lfdr.de>; Tue, 17 Mar 2020 14:42:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8B68A4B08A;
	Tue, 17 Mar 2020 09:42:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yRyE2ts8zVWc; Tue, 17 Mar 2020 09:42:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 611DF4B097;
	Tue, 17 Mar 2020 09:42:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 032FE4A51E
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Mar 2020 09:11:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fVHwdTOyxD7S for <kvmarm@lists.cs.columbia.edu>;
 Tue, 17 Mar 2020 09:11:00 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 79FDC4A319
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Mar 2020 09:11:00 -0400 (EDT)
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de
 [95.90.212.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6300120771;
 Tue, 17 Mar 2020 13:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584450659;
 bh=wj5NkzbISu9o2utN78bxPeqq1ZgvydCMMryyeO/xzBU=;
 h=From:To:Cc:Subject:Date:From;
 b=jhQXGRpyEjN1FbAvcv9quZfGePLCoK4kU909OULrkuYhnOKG38jWSBAxykmFtnPEc
 FmxsmxL6osKlKdWLuFSmfK9Bc26tcpyTHH+GVRCjBz/zbJaE7+EUQig6/jG7Ef2Xw2
 zXXfz+9+g7PLdkQHLfuE/QRAg89PRDvvy0ezvspc=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
 (envelope-from <mchehab@kernel.org>)
 id 1jEBzh-0006Rm-EN; Tue, 17 Mar 2020 14:10:53 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: [PATCH 00/12] Fix broken references for Documentation/*
Date: Tue, 17 Mar 2020 14:10:39 +0100
Message-Id: <cover.1584450500.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 17 Mar 2020 09:42:09 -0400
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Linus Walleij <linus.walleij@linaro.org>, dri-devel@lists.freedesktop.org,
 Paul Mackerras <paulus@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-arch@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Tyler Hicks <code@tyhicks.com>,
 Christoph Hellwig <hch@infradead.org>, Doug Ledford <dledford@redhat.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
 linux-pm@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Jyri Sarha <jsarha@ti.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>, Sean Paul <sean@poorly.run>,
 Anton Altaparmakov <anton@tuxera.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, freedreno@lists.freedesktop.org,
 Wanpeng Li <wanpengli@tencent.com>,
 Benjamin Gaignard <benjamin.gaignard@st.com>, David Airlie <airlied@linux.ie>,
 Harry Wei <harryxiyou@gmail.com>, Corentin Labbe <clabbe.montjoie@gmail.com>,
 Ben Peled <bpeled@marvell.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 kvmarm@lists.cs.columbia.edu, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Wolfgang Grandegger <wg@grandegger.com>, Andrea Parri <parri.andrea@gmail.com>,
 linux-arm-msm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Nicolas Pitre <nico@fluxnic.net>,
 linux-ntfs-dev@lists.sourceforge.net, Miklos Szeredi <miklos@szeredi.hu>,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Akira Yokosawa <akiyks@gmail.com>, Alex Shi <alex.shi@linux.alibaba.com>,
 Will Deacon <will@kernel.org>, linux-afs@lists.infradead.org,
 Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-rdma@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Chen-Yu Tsai <wens@csie.org>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org,
 Federico Vaga <federico.vaga@vaga.pv.it>, Jade Alglave <j.alglave@ucl.ac.uk>,
 Alexey Dobriyan <adobriyan@gmail.com>, linux-pwm@vger.kernel.org,
 Gregory CLEMENT <gregory.clement@bootlin.com>, Borislav Petkov <bp@alien8.de>,
 Maxime Ripard <maxime@cerno.tech>, Luc Maranget <luc.maranget@inria.fr>,
 Yuti Amonkar <yamonkar@cadence.com>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, ocfs2-devel@oss.oracle.com,
 Jan Kara <jack@suse.cz>, kvm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
 "H. Peter Anvin" <hpa@zytor.com>, Amit Kucheria <amit.kucheria@verdurent.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Mark Fasheh <mark@fasheh.com>, x86@kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>,
 Zhang Rui <rui.zhang@intel.com>, Mike Leach <mike.leach@linaro.org>,
 devicetree@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, Daniel Lustig <dlustig@nvidia.com>,
 ecryptfs@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Rob Herring <robh+dt@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 David Sterba <dsterba@suse.com>, Jim Mattson <jmattson@google.com>,
 netdev@vger.kernel.org, linux-unionfs@vger.kernel.org,
 Rob Clark <robdclark@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, Joerg Roedel <joro@8bytes.org>,
 Joel Becker <jlbec@evilplan.org>
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

This patch series is against next-20200317. It fixes all references to files
under Documentation/* that were moved, renamed or removed.

After this patch series, this script:
	./scripts/documentation-file-ref-check

Doesn't complain about any broken reference.

Mauro Carvalho Chehab (12):
  MAINTAINERS: dt: update display/allwinner file entry
  MAINTAINERS: dt: update etnaviv file reference
  MAINTAINERS: drop an old reference to stm32 pwm timers doc
  docs: dt: fix references to m_can.txt file
  docs: dt: fix references to ap806-system-controller.txt
  docs: dt: fix a broken reference to input.yaml
  docs: dt: fix broken reference to phy-cadence-torrent.yaml
  docs: fix broken references to text files
  docs: fix broken references for ReST files that moved around
  docs: dt: display/ti: fix typos at the devicetree/ directory name
  docs: filesystems: fix renamed references
  docs: kernel-parameters.txt: remove reference for removed Intel MPX

 Documentation/ABI/stable/sysfs-devices-node   |  2 +-
 Documentation/ABI/testing/procfs-smaps_rollup |  2 +-
 Documentation/admin-guide/cpu-load.rst        |  2 +-
 .../admin-guide/kernel-parameters.txt         | 11 ++--
 Documentation/admin-guide/nfs/nfsroot.rst     |  2 +-
 .../bindings/arm/freescale/fsl,scu.txt        |  2 +-
 .../bindings/display/ti/ti,am65x-dss.yaml     |  2 +-
 .../bindings/display/ti/ti,j721e-dss.yaml     |  2 +-
 .../bindings/display/ti/ti,k2g-dss.yaml       |  2 +-
 .../devicetree/bindings/gpio/gpio-mvebu.txt   |  2 +-
 .../devicetree/bindings/net/can/tcan4x5x.txt  |  2 +-
 .../bindings/phy/ti,phy-j721e-wiz.yaml        |  2 +-
 .../bindings/thermal/armada-thermal.txt       |  2 +-
 .../doc-guide/maintainer-profile.rst          |  2 +-
 .../driver-api/driver-model/device.rst        |  4 +-
 .../driver-api/driver-model/overview.rst      |  2 +-
 Documentation/filesystems/dax.txt             |  2 +-
 Documentation/filesystems/dnotify.txt         |  2 +-
 .../filesystems/ramfs-rootfs-initramfs.rst    |  2 +-
 Documentation/filesystems/sysfs.rst           |  2 +-
 Documentation/memory-barriers.txt             |  2 +-
 .../powerpc/firmware-assisted-dump.rst        |  2 +-
 Documentation/process/adding-syscalls.rst     |  2 +-
 Documentation/process/submit-checklist.rst    |  2 +-
 .../it_IT/process/adding-syscalls.rst         |  2 +-
 .../it_IT/process/submit-checklist.rst        |  2 +-
 .../translations/ko_KR/memory-barriers.txt    |  2 +-
 .../translations/zh_CN/filesystems/sysfs.txt  |  8 +--
 .../zh_CN/process/submit-checklist.rst        |  2 +-
 Documentation/virt/kvm/arm/pvtime.rst         |  2 +-
 Documentation/virt/kvm/devices/vcpu.rst       |  2 +-
 Documentation/virt/kvm/hypercalls.rst         |  4 +-
 Documentation/virt/kvm/mmu.rst                |  2 +-
 Documentation/virt/kvm/review-checklist.rst   |  2 +-
 MAINTAINERS                                   | 61 +++++++++----------
 Next/merge.log                                | 12 ++--
 arch/powerpc/include/uapi/asm/kvm_para.h      |  2 +-
 arch/x86/kvm/mmu/mmu.c                        |  2 +-
 drivers/base/core.c                           |  2 +-
 .../allwinner/sun8i-ce/sun8i-ce-cipher.c      |  2 +-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c |  2 +-
 .../allwinner/sun8i-ss/sun8i-ss-cipher.c      |  2 +-
 .../crypto/allwinner/sun8i-ss/sun8i-ss-core.c |  2 +-
 drivers/gpu/drm/Kconfig                       |  2 +-
 drivers/gpu/drm/drm_ioctl.c                   |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h       |  2 +-
 drivers/hwtracing/coresight/Kconfig           |  2 +-
 drivers/media/v4l2-core/v4l2-fwnode.c         |  2 +-
 fs/Kconfig                                    |  2 +-
 fs/Kconfig.binfmt                             |  2 +-
 fs/adfs/Kconfig                               |  2 +-
 fs/affs/Kconfig                               |  2 +-
 fs/afs/Kconfig                                |  6 +-
 fs/bfs/Kconfig                                |  2 +-
 fs/cramfs/Kconfig                             |  2 +-
 fs/ecryptfs/Kconfig                           |  2 +-
 fs/fat/Kconfig                                |  8 +--
 fs/fuse/Kconfig                               |  2 +-
 fs/fuse/dev.c                                 |  2 +-
 fs/hfs/Kconfig                                |  2 +-
 fs/hpfs/Kconfig                               |  2 +-
 fs/isofs/Kconfig                              |  2 +-
 fs/namespace.c                                |  2 +-
 fs/notify/inotify/Kconfig                     |  2 +-
 fs/ntfs/Kconfig                               |  2 +-
 fs/ocfs2/Kconfig                              |  2 +-
 fs/overlayfs/Kconfig                          |  6 +-
 fs/proc/Kconfig                               |  4 +-
 fs/romfs/Kconfig                              |  2 +-
 fs/sysfs/dir.c                                |  2 +-
 fs/sysfs/file.c                               |  2 +-
 fs/sysfs/mount.c                              |  2 +-
 fs/sysfs/symlink.c                            |  2 +-
 fs/sysv/Kconfig                               |  2 +-
 fs/udf/Kconfig                                |  2 +-
 include/linux/kobject.h                       |  2 +-
 include/linux/kobject_ns.h                    |  2 +-
 include/linux/mm.h                            |  4 +-
 include/linux/relay.h                         |  2 +-
 include/linux/sysfs.h                         |  2 +-
 include/uapi/linux/ethtool_netlink.h          |  2 +-
 include/uapi/linux/kvm.h                      |  4 +-
 include/uapi/rdma/rdma_user_ioctl_cmds.h      |  2 +-
 kernel/relay.c                                |  2 +-
 lib/kobject.c                                 |  4 +-
 mm/gup.c                                      | 12 ++--
 tools/include/uapi/linux/kvm.h                |  4 +-
 virt/kvm/arm/vgic/vgic-mmio-v3.c              |  2 +-
 virt/kvm/arm/vgic/vgic.h                      |  4 +-
 89 files changed, 151 insertions(+), 151 deletions(-)

-- 
2.24.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
