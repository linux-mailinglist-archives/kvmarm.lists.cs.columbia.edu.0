Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 42AAC183638
	for <lists+kvmarm@lfdr.de>; Thu, 12 Mar 2020 17:33:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CED444A4F6;
	Thu, 12 Mar 2020 12:33:06 -0400 (EDT)
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
	with ESMTP id 3Mn-iHfn2PsF; Thu, 12 Mar 2020 12:33:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CB77E4A51F;
	Thu, 12 Mar 2020 12:33:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 522DC4A51F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Mar 2020 12:33:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sTDGC3gKTesZ for <kvmarm@lists.cs.columbia.edu>;
 Thu, 12 Mar 2020 12:33:03 -0400 (EDT)
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 681904A4F6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Mar 2020 12:33:03 -0400 (EDT)
Received: by mail-ot1-f66.google.com with SMTP id t28so4299431ott.5
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Mar 2020 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0VRQIv4qXD7Q5fEXczD6vOATnHwuTS2cyDP1QenEnps=;
 b=MHzgIensqHxS/3cxZERb3e3XdvDQgU1GjlryxvGwB1bgIgw+JbE+enfvDyonB3f8gM
 JnpcV1DAUyKyX/ipEBnESgQBXOyxs84B6XQxy+w0hpy5q1f1lZskT8gMhWafZvCjU8vu
 pfaICmM0xEccLFKpQA3tllm635JBBL4l1XiERi+YDqAA2nRE+uDOKOYw3BhigSmmecMW
 yYEK73tlWmhBkpy6JwrrrtlzJ9P5ca8iy3GnFCEHPh6InXhLe/93sysmRKRGxtAeulvr
 FRD50l9e9HlVFC+QSVcP5AWWDo0O0huF8PLvuiBMGcu7+5ghCc1TOR+howe0OaLTKGnH
 DqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0VRQIv4qXD7Q5fEXczD6vOATnHwuTS2cyDP1QenEnps=;
 b=tRbnmxywU29i5WMlflpIlymbVaeXDTu6P6nGBFe2+egsQhZ8d2SJk4IVy0Gb6GO294
 5BUSqPh/talBQRoh4zA4TFxnh5OhcFQUNlJ7MG3S3Ead9tlDXxlZ1k8vyd+Jy6x8GR/3
 +UEl90tgHz86ksJWgWGVdYo0x1trDKAHAoBLhf+kiPCCdZtJXuPbVWnTkgXOy4kL+E+1
 JiSxVS8JCkW076Z7Do4U3rj5ff/mcDm2Xs9UAoKx+L50Nt6youYDwAHGs856Ihz8Lq9b
 itw8XUkSVdkWlMLj3HBFgIczAUJz3ieeH/smR0v3tDRELO1/Yj//o8bxypw7DYryHaSq
 lEdg==
X-Gm-Message-State: ANhLgQ3irg7OZnH23/dSvTw0pQMKW2Pmmz1woLmBHI7eQiNkwQTGXUc2
 +A0CIQ6DOIopLLkiYJvSTmXFn+A+Cpo7NH9WvlRT2w==
X-Google-Smtp-Source: ADFU+vsQTL+6pcesecAzObSP/AMwX5+2/sIepkjwZse514F/Bluy0l5CbOVfSwNDL3YK6i4MXxcyW+23beeY+Qb7fMs=
X-Received: by 2002:a9d:6f88:: with SMTP id h8mr7105904otq.91.1584030782701;
 Thu, 12 Mar 2020 09:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200312003401.29017-1-beata.michalska@linaro.org>
 <20200312003401.29017-2-beata.michalska@linaro.org>
In-Reply-To: <20200312003401.29017-2-beata.michalska@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2020 16:32:51 +0000
Message-ID: <CAFEAcA_5avBsNJUDh6o8vGfm4DGcFA-iT-UNG5h8M+hPDOif9g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] target/arm: kvm: Inject events at the last stage
 of sync
To: Beata Michalska <beata.michalska@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
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

On Thu, 12 Mar 2020 at 00:34, Beata Michalska
<beata.michalska@linaro.org> wrote:
>
> KVM_SET_VCPU_EVENTS might actually lead to vcpu registers being modified.
> As such this should be the last step of sync to avoid potential overwriting
> of whatever changes KVM might have done.
>
> Signed-off-by: Beata Michalska <beata.michalska@linaro.org>

Hi; I'm going to take patch 1 into target-arm.next since it
seems worth having on its own and I'm doing a pullreq today
anyway. Andrew's given you feedback on patch 2.

thanks
-- PMM
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
