Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA02489D01
	for <lists+kvmarm@lfdr.de>; Mon, 10 Jan 2022 17:02:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6B7ED4B161;
	Mon, 10 Jan 2022 11:02:16 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NXFHC8nsg-fK; Mon, 10 Jan 2022 11:02:16 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F3B5B4B191;
	Mon, 10 Jan 2022 11:02:14 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D67944B186
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Jan 2022 11:02:13 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HHbuHCicrMkv for <kvmarm@lists.cs.columbia.edu>;
 Mon, 10 Jan 2022 11:02:09 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F20DA4B161
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Jan 2022 11:02:08 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7798660B9F;
 Mon, 10 Jan 2022 16:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0242C36AE3;
 Mon, 10 Jan 2022 16:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641830526;
 bh=fuz9oNXrm2Hf4a0RANGkIs6aiYecMqw64RGc7bXvONI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=BNQ0DoNDVNdrSom+IIrIk4Bg6r7+4jYAMpYsNI1zKIUEBoikgoBEdBSRPQYj1M4E/
 3dZYRiKGrcy6pHcO6c3e68yw1Ke4ZIjXfj3GE8WDwlj2k6TjULEnDQYUiw3DU62cZO
 jtI4Smf0z/smYwPI6l4MqPsCwOxK0dNXEwWtsBA/Xg2T2QRfLKndwjMPYF6DipUJGU
 BX8//LBkz6EF6LiSK4FQyBVz5/DbLq5EFFGoGiwFSK/S5a2h+QkeGiEkccoP8rpRX3
 yYzf2HLLbxABY4QgYglgBH0lOW0uShMOvJk6+w9KHcTl0tAshbCL5v55Iv27vIkD8F
 YgaHoOyvlYjRA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1n6x7U-00HAlH-VM; Mon, 10 Jan 2022 16:02:05 +0000
Date: Mon, 10 Jan 2022 16:02:04 +0000
Message-ID: <87h7abtw8z.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v4 2/6] hw/arm/virt: Add a control for the the highmem
 redistributors
In-Reply-To: <CAFEAcA-OF29ptHr0X9ojyLEcDw9v7Smc5PC3O+v5Uv3bjiSmRA@mail.gmail.com>
References: <20220107163324.2491209-1-maz@kernel.org>
 <20220107163324.2491209-3-maz@kernel.org>
 <448274ac-2650-7c09-742d-584109fb5c56@redhat.com>
 <87k0f7tx17.wl-maz@kernel.org>
 <CAFEAcA-OF29ptHr0X9ojyLEcDw9v7Smc5PC3O+v5Uv3bjiSmRA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: peter.maydell@linaro.org, eric.auger@redhat.com,
 qemu-devel@nongnu.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 kernel-team@android.com, drjones@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, kernel-team@android.com,
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

On Mon, 10 Jan 2022 15:47:47 +0000,
Peter Maydell <peter.maydell@linaro.org> wrote:
> 
> On Mon, 10 Jan 2022 at 15:45, Marc Zyngier <maz@kernel.org> wrote:
> > $ /home/maz/vminstall/qemu-hack -m 1G -smp 256 -cpu host -machine virt,accel=kvm,gic-version=3,highmem=on -nographic -drive if=pflash,format=raw,readonly=on,file=/usr/share/AAVMF/AAVMF_CODE.fd
> > qemu-hack: warning: Number of SMP cpus requested (256) exceeds the recommended cpus supported by KVM (8)
> > qemu-hack: warning: Number of hotpluggable cpus requested (256) exceeds the recommended cpus supported by KVM (8)
> > qemu-hack: Capacity of the redist regions(123) is less than number of vcpus(256)
> 
> Side question: why is KVM_CAP_NR_VCPUS returning 8 for
> "recommended cpus supported by KVM" ? Is something still
> assuming GICv2 CPU limits?

No, it is only that KVM_CAP_NR_VCPUS is defined as returning the
number of physical CPUs (and this test machine has only 8 of them).

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
