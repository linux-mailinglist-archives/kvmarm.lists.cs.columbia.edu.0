Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 399B5FC9E6
	for <lists+kvmarm@lfdr.de>; Thu, 14 Nov 2019 16:27:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BF8CC4AF06;
	Thu, 14 Nov 2019 10:27:39 -0500 (EST)
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
	with ESMTP id 7bwk1JnBqRDS; Thu, 14 Nov 2019 10:27:39 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 920FA4AED4;
	Thu, 14 Nov 2019 10:27:38 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 00A564AEC1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Nov 2019 10:27:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ae3rTtOJzAhY for <kvmarm@lists.cs.columbia.edu>;
 Thu, 14 Nov 2019 10:27:37 -0500 (EST)
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 239184AEBA
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Nov 2019 10:27:37 -0500 (EST)
Received: by mail-ot1-f68.google.com with SMTP id f10so5180938oto.3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Nov 2019 07:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VeY2MOcdaw6r8Ha9Eh1pv27RGxet0wBjyhB8nwJtLCk=;
 b=E9N2cNleSycQiDuGwZ+D654dUj+mEaTT0Od4euVyQpoOBSULhMe0pOdzpWK59wPvli
 51UPfgDM/E6mfWUBs6ODMQGUiPxrUmztDY7i3xxthKvaSDh4D+3diA+0m5MZ4jo0lIut
 fO1pAxw5E6moagkNWVB+eMUpGn3ElVVRMfER30Mch4axBfTda+uUy1vVSG5nNierNRri
 ZTbcPm9spj2XanM2IM0hV7UFs72Ikxcl9eUMkRZX15oDIlbdCYBobYJUhT38may1hpkS
 4YifZWRxZRTa6gbyfuMrTewbdi6HbtBZYo0gebulIbOiUh+EJaeCAjCRUj50kAfiv8WV
 xz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VeY2MOcdaw6r8Ha9Eh1pv27RGxet0wBjyhB8nwJtLCk=;
 b=Vulse24jpwuqn5IjzDxCjL/LuG+3uzbGKQyJQbVr9QwDc6VsLo/VRky1/kvyxmaTPw
 v5UzSl304PNUm9DLquOQ6xPIr9xxK+QcPQmyIS4U/XWVBOnO54Z5M/WAdC6DQ39bqNYl
 g/v0BWboIo3vZhLGDhIvvgtgFzVjQUQK+BcG3omwJKO78ZM5dO7Je5rSfvgPgRWvfKwK
 lIVYyIwI/Bzis5fKHtEt2UZe/6kcf/b3k8R+DocSZ9EzQB2d092Wv9rGZQERqp3eyAPL
 iJsL2ZDRVnL7kLKgsKtjFZDy/cT2rKVMnzbb4htH2AH6s91hNYfh8/BXPktasa3Ko9EI
 W+YQ==
X-Gm-Message-State: APjAAAUf/8cZDIAnQCxOU8RQjXfdTsmL6aLMUe/pYr9/oU240W1fCTAU
 oLAbiyn+OaiFVHNE1nsPeJalDkL+N+AfIYFNHNKO/Q==
X-Google-Smtp-Source: APXvYqz6c/gHgYRtpNX09mwAgZqZcQnoq6B/kPCnPlGTV64hqbThdZMLMuxrXe0XfBKKQS1wp0ZTLQ/eHN/071eq9Zk=
X-Received: by 2002:a9d:7f12:: with SMTP id j18mr7112499otq.221.1573745256587; 
 Thu, 14 Nov 2019 07:27:36 -0800 (PST)
MIME-Version: 1.0
References: <20191108144240.204202-1-andre.przywara@arm.com>
 <20191108144240.204202-10-andre.przywara@arm.com>
 <2e14ccd4-89f4-aa90-cc58-bebf0e2eeede@arm.com>
 <7ca57a0c-3934-1778-e3f9-a3eee0658002@arm.com>
 <20191114141745.32d3b89c@donnerap.cambridge.arm.com>
 <90cdc695-f761-26bd-d2a7-f8655ce04463@arm.com>
 <187393bb-a32d-092d-d0ea-44c58a54d1de@arm.com>
In-Reply-To: <187393bb-a32d-092d-d0ea-44c58a54d1de@arm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Nov 2019 15:27:25 +0000
Message-ID: <CAFEAcA_kcQwrnJxtCynX9+hMEvnFN0yBnim_Kn-uut5P4fshew@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH 09/17] arm: gic: Add test for flipping
 GICD_CTLR.DS
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: kvm-devel <kvm@vger.kernel.org>, Andre Przywara <andre.przywara@arm.com>,
 Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>
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

On Thu, 14 Nov 2019 at 15:21, Alexandru Elisei <alexandru.elisei@arm.com> wrote:
> TCG emulates a GIC with a single security state for me:
>
> /usr/bin/qemu-system-aarch64 -nodefaults -machine virt,gic-version=3,accel=tcg
> -cpu cortex-a57 -device virtio-serial-device -device virtconsole,chardev=ctd
> -chardev testdev,id=ctd -device pci-testdev -display none -serial stdio -kernel
> arm/gic.flat -append irq

The virt board doesn't do EL3 by default, but if you add -machine secure=true
to your command line then it it should emulate it, including a
trustzone-aware GIC.

thanks
-- PMM
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
