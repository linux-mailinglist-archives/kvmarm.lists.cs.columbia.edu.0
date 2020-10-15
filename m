Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 20A7E28F564
	for <lists+kvmarm@lfdr.de>; Thu, 15 Oct 2020 16:57:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ABC404B45D;
	Thu, 15 Oct 2020 10:57:18 -0400 (EDT)
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
	with ESMTP id yxp0f88D-gW9; Thu, 15 Oct 2020 10:57:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8A4D84B6FF;
	Thu, 15 Oct 2020 10:57:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D2304B464
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Oct 2020 10:57:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E-uP3hr7wjCK for <kvmarm@lists.cs.columbia.edu>;
 Thu, 15 Oct 2020 10:57:15 -0400 (EDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2C16C4B262
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Oct 2020 10:57:15 -0400 (EDT)
Received: by mail-ej1-f52.google.com with SMTP id lw21so4062464ejb.6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Oct 2020 07:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G0MtCDtWq/32YqRkQgDeY0B5ASaZ76/mMIxhaRr+/fo=;
 b=pMpwPpWtoVOjo5K05m+Kep9rlRTdq4hY/akrLz1CCA68nVvmGVgs8Xl2wKARLJRn5Q
 /ulFsgxcW00wW6SNnjhg5C+tzIBw9PZ9JkyRknB8nL36DX3CNWHvW32pRlgHUa9DJoiH
 MGGHCM/QUfRR/IpD1YFy35Mid8yQ+VtFMSWZUaDB5D1gsGTP02WhJgC5anoB86lcrmFR
 ZerCor+aCxkoc5pUy+R9mhlqjx+9fW9j5U5sVFdlrEbAsV4fsmsLlIV4iNnVzqoxFjtJ
 uD7kQEsP50h4Sq+KfrRQkCRyXl00WD2FPHpyCXqmrG8hnG7XZBChZZ0aLS0Jj43rstIy
 xxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G0MtCDtWq/32YqRkQgDeY0B5ASaZ76/mMIxhaRr+/fo=;
 b=sZ0UqwEH3hTvJkt6iEvruwHT15jPsSGvBw0i0MoGaJ7J5b3FRtpZFSSoHNadypCD1P
 SP/XKtZexEBSp44h09KcyQCyaMtgH7QVMq5mXdfdU0HFUNzhDrFho0y7iac/vr0gm7v2
 VsqjCHGRgnfFQ04JxHKa9aqfc5oBC0NtkRIBSKvFKZ1IwFeFbHFWwfKcvzEbByqFp2Mj
 z/HDocUXw6zhbN2e6ojahD6tYauj3/3A6bsbojl+2xL06+sAd9YPs2PiijDVEyPB+jwX
 tsf6LcV1yYLip5WNFYUcxGoXL8m2SAWv9jfJkmXRqa1xVlUDQkABo7uuGlA0fl6UFTkH
 MNQQ==
X-Gm-Message-State: AOAM532CvGPtOz/W/Z71HaLHdH+4ZZOwBOL+Xr//+AFvJimOKgyQ1R20
 Xsdn37mlFqRA88yHlXtxVTsb+9hMl/+ibX0WlvmkKA==
X-Google-Smtp-Source: ABdhPJz1lIzvU38dvHqcMsbMHkWrDPEAFvCVE/tsPnZNgvVnBLtWLnAF6/xb4n+B6xmwp1QrE+zLRNxC5Jt9Srh51a8=
X-Received: by 2002:a17:906:3a97:: with SMTP id
 y23mr4946926ejd.250.1602773834128; 
 Thu, 15 Oct 2020 07:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201015040639.70C6D414009F@webmail.sinamail.sina.com.cn>
 <7fecfc67da4caab1d677a8b4cd5386b3@kernel.org>
 <20201015133505.ubxvbrt6xyvl4362@kamzik.brq.redhat.com>
 <16400df4bdf79b8b22e824eb1a20e2b4@kernel.org>
 <20201015144104.ytwzpxjlsgyun3ob@kamzik.brq.redhat.com>
In-Reply-To: <20201015144104.ytwzpxjlsgyun3ob@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2020 15:57:02 +0100
Message-ID: <CAFEAcA-LBmbjp-Teb35f=O-1QtMLd8bAuq5XaCz9URdQZ1jxow@mail.gmail.com>
Subject: Re: Kernel patch cases qemu live migration failed.
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Marc Zyngier <maz@kernel.org>,
 xu910121@sina.com, "Dave.Martin" <dave.martin@arm.com>,
 kvmarm <kvmarm@lists.cs.columbia.edu>
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

On Thu, 15 Oct 2020 at 15:41, Andrew Jones <drjones@redhat.com> wrote:
> The reporter states neither the source nor destination hardware supports
> SVE. My guess is that what's happening is the reserved ID register
> ID_UNALLOCATED(4,4) was showing up in the KVM_GET_REG_LIST count on
> the old kernel, but the new kernel filters it out. Maybe it is a
> bug to filter it out of the count, as it's a reserved ID register and
> I suppose the other reserved ID registers are still showing up?

Yeah, RES0 ID registers should show up in the list, because otherwise
userspace has to annoyingly special case them when the architecture
eventually defines behaviour for them.

Dave's comment in the kernel commit message
# ID_AA64ZFR0_EL1 is RO-RAZ for MRS/MSR when SVE is disabled for the
# guest, but for compatibility with non-SVE aware KVM implementations
# the register should not be enumerated at all for KVM_GET_REG_LIST
# in this case.
seems wrong to me -- for compatibility the register should remain
present and behave as RAZ/WI if SVE is disabled in the guest,
the same way it was before the kernel/KVM knew about SVE at all.

thanks
-- PMM
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
