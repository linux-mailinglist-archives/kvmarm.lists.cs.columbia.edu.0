Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 76B6A20C2D2
	for <lists+kvmarm@lfdr.de>; Sat, 27 Jun 2020 17:29:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 104B34B39A;
	Sat, 27 Jun 2020 11:29:47 -0400 (EDT)
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
	with ESMTP id VdY8GjEw+oLc; Sat, 27 Jun 2020 11:29:46 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 155974B38A;
	Sat, 27 Jun 2020 11:29:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7274F4B20F
 for <kvmarm@lists.cs.columbia.edu>; Sat, 27 Jun 2020 11:29:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CkqWjp-sMqsP for <kvmarm@lists.cs.columbia.edu>;
 Sat, 27 Jun 2020 11:29:43 -0400 (EDT)
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com
 [209.85.166.66])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 66F544B204
 for <kvmarm@lists.cs.columbia.edu>; Sat, 27 Jun 2020 11:29:43 -0400 (EDT)
Received: by mail-io1-f66.google.com with SMTP id o5so12811416iow.8
 for <kvmarm@lists.cs.columbia.edu>; Sat, 27 Jun 2020 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=252szu6XzUhLi/t7tMEXBw3LKBY2LFN/dKLgnNNeVDc=;
 b=xcJMPM5PtUwGdXF9WpgyMhzmmJM0m3UHhhPYiE/atwnTB9/zZ4lb+t++t9NgjGeDmU
 5hXuE3tVim9ssRjcrCQAGA0oScWWBUfNsTPz4gVKPtLWaYDWWsVJDbll3KeyaC+YYhw6
 SJN/7UResDGSf1nutm59YvtUqCz45zgipGvtqw/RSijiyjJ9dDU87x9dWREFWuF0ofpf
 5ogi8TcSuDnOWTbScnGM3z/KjrJv40Jvj0Y7frJXud4kHvy34KYq5OkoDiR4IBQW26Qq
 2vExnP6/plwzmZO2s3NdJLJloW4H5yF0qrmdRY78LQ5I3tE/4uAXLeG7pgHXHcJ72orU
 SAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=252szu6XzUhLi/t7tMEXBw3LKBY2LFN/dKLgnNNeVDc=;
 b=YKeBgvOAqVzA23c1wbGPnPXxP/0kRBVkEX906YhkQTlXRAmjINthIbR4kHSQ3WZjup
 QPGO80f5umlfIyyffcz22sZQXP6iRYRVaxNRxyEsE1AI7ypAzbWEehlC+2FOd2suefqD
 Msx/2WIkoOzlozlrY2Q67g1SDpnQmwWECUZWM+h0oHNt4Xpx7B05bai39SH3RWXBIGTM
 qReA3TDZ2D/5uoPdpUmtyeUs6RGZEJgFpKvX7C5/1/b4zxq5X/CYg9p4160VjyOJW2w2
 TFjlWpxAubWHF2YJu9iic4GY1EPkGyLz6UOvkC4qUj4hKbu2DC7hBskTZcKXcVFCWAVC
 QzzA==
X-Gm-Message-State: AOAM532VsJ3+roaUEN7P7ZU+iPp6O8h76tPbW+3VtXhRYti//9CpzWPs
 HOjlx1ZyyxMRJmXggf9bjkvOsJEFDoGfCnLAeGvSMQ==
X-Google-Smtp-Source: ABdhPJweNTk+JFRbCcjbr/b9ENxsKkQ9kIC2D/wKEWxBzt4spSejJp4f7gO/mrDi14hHwQkPEM8oFWs5FXNQLqEY68Y=
X-Received: by 2002:a6b:3bc6:: with SMTP id i189mr8826577ioa.180.1593271782692; 
 Sat, 27 Jun 2020 08:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200625220336.10186-1-beata.michalska@linaro.org>
 <20200625220336.10186-2-beata.michalska@linaro.org>
 <20200626090050.3sqsukopwydv43od@kamzik.brq.redhat.com>
 <CAFEAcA_pKMkwAGAAdkCXk3dOqJQnX+qRsZuLMWA0qfMsw+aF1Q@mail.gmail.com>
In-Reply-To: <CAFEAcA_pKMkwAGAAdkCXk3dOqJQnX+qRsZuLMWA0qfMsw+aF1Q@mail.gmail.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Sat, 27 Jun 2020 16:29:31 +0100
Message-ID: <CADSWDzvW3v0bVaEjaPLSk_N4c8nA_ZcReerh2dd3Lg2jgDRiHQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] target/arm: kvm: Handle DABT with no valid ISS
To: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 kvmarm@lists.cs.columbia.edu, QEMU Developers <qemu-devel@nongnu.org>
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

Hi Peter,
Hi Andrew

Thanks for quick review.
I have pushed the updated version.

BR
Beata

On Fri, 26 Jun 2020 at 13:59, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 26 Jun 2020 at 10:01, Andrew Jones <drjones@redhat.com> wrote:
> > nit: How about using '= {0}' when declaring the variable, rather than this
> > memset?
>
> We prefer "= {}" -- although "= {0}" is the C standard approved
> version, some compiler versions produce spurious warnings for
> it in some situations. (cf commit 039d4e3df0049bdd8f9).
>
> thanks
> -- PMM
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
