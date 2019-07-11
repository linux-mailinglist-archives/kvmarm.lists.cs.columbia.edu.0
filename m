Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DA5A265393
	for <lists+kvmarm@lfdr.de>; Thu, 11 Jul 2019 11:14:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 48DE74A516;
	Thu, 11 Jul 2019 05:14:12 -0400 (EDT)
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
	with ESMTP id nQpeMaKgi6c1; Thu, 11 Jul 2019 05:14:12 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 348FC4A4FA;
	Thu, 11 Jul 2019 05:14:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 566D74A4F3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Jul 2019 05:14:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aYlpXEvnr8nF for <kvmarm@lists.cs.columbia.edu>;
 Thu, 11 Jul 2019 05:14:09 -0400 (EDT)
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 375874A4CA
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Jul 2019 05:14:09 -0400 (EDT)
Received: by mail-oi1-f196.google.com with SMTP id 65so3916832oid.13
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Jul 2019 02:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MEZG43r6RWPqN4gSL/BMuAlx0Ls8cNhdW0tYLDnHU8A=;
 b=Zv+KUbRkxwDNfleJFVK3oTMNs+Ze4+tknfaP0s/vKQbHstBLp8Kt9h2lUWkuBVeDZq
 kqWrEo3Pw+hajDCbmhJixJFHWsKh3NJ1nfS0+yF9zZzZUT4isdT0hlyjtQsxfJ/FuCWF
 vwzoxorUfH+yRc3JH3QpKUdQK85PlIWLSNGFYo10e8ZVK+DR0H110bcrtT9nCvUZ1K73
 hfIWm6JqMhp5ehH6f38sqQdOP1kCGeqtdznLScxPNPEehUAEajUQ9tEFUL1GTrCobUkY
 HTZjIcjL8eDVpj3zWKwVgDRZBGlehYIwYrO4jTY7ABzx6yfrUz1ZKCQ2LShDyWS+eKPg
 oYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MEZG43r6RWPqN4gSL/BMuAlx0Ls8cNhdW0tYLDnHU8A=;
 b=GQ1kse7RHTbPAH2m5Puvl8GYJYdMJeOPsTHd9NJnWwyb9bIWMrjg2KWh4WkMr6pHl9
 54ZpyPUnvKdqHn47FbbhFJ4HNc4pG8WeVmSdIcfvTN/jHO1bNp+TV7tPRZDOyFKx1aki
 mNuvex4hUadb9XGuoEqhrpP20K9aOcoAU+al41vwtcMBEJpiePTgRd63mTgHZPq7pXRU
 I75p4d/3u1z+/sReUkXQeFve1103lV3urvP686soWUVC02EqYJ8W9M6kG3MIzinUNj4j
 oAMZad5l0MbxNW4rgGcgWZlv1d+tbkmyx0rLdWI/dEbQCvaX0bVarIbmw1f+Ql46cIlo
 fARQ==
X-Gm-Message-State: APjAAAX92/DwZKU+ZZyyd4nIjDoSbzvoeMQ7iUpYkbVSS35ixSeIf4j7
 6xQoHjObSYHAhbsYbXwMsBg+obW9t6JrSKAuwirZWQ==
X-Google-Smtp-Source: APXvYqzQhZHQWC6BrWJ9rVgTKnyu2xj51GbJRtgxsikp+PgoFMpk/4509qrz9K6SAZJgfcpPiLZs6ARrqQFt119+joM=
X-Received: by 2002:aca:6185:: with SMTP id v127mr1833969oib.163.1562836448490; 
 Thu, 11 Jul 2019 02:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190710132724.28350-1-graf@amazon.com>
 <CAFEAcA81mQ780H5EY8uV6AvbXzeZA60eCHoE_n9yzeZgw+ru4w@mail.gmail.com>
 <a29ea772-0565-98cb-61d8-3042b2df39b1@amazon.com>
In-Reply-To: <a29ea772-0565-98cb-61d8-3042b2df39b1@amazon.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2019 10:13:57 +0100
Message-ID: <CAFEAcA_qRksJGiOZXFss+7Bcuwy97LydQXcw-R=LD7zBTmEm6g@mail.gmail.com>
Subject: Re: [PATCH kvm-unit-tests] arm: Add PL031 test
To: Alexander Graf <graf@amazon.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu, kvm-devel <kvm@vger.kernel.org>
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

On Thu, 11 Jul 2019 at 10:11, Alexander Graf <graf@amazon.com> wrote:
> On 11.07.19 10:51, Peter Maydell wrote:
> > Have you tested this against a real hardware pl031?

> Do you have any pointers to devices I might own that have one?

Heh, fair point. I'd expect to find one in most of the devboards
Arm has shipped over the years, but I dunno if you'll find one
anywhere else.

thanks
-- PMM
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
