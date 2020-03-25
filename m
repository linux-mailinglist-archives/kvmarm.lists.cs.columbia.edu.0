Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1629B192C0B
	for <lists+kvmarm@lfdr.de>; Wed, 25 Mar 2020 16:17:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A71D04B093;
	Wed, 25 Mar 2020 11:17:03 -0400 (EDT)
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
	with ESMTP id fwS+GZ3eOJVQ; Wed, 25 Mar 2020 11:17:03 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6A49C4B090;
	Wed, 25 Mar 2020 11:17:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D44994A531
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Mar 2020 11:17:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i1K1Go85yvtA for <kvmarm@lists.cs.columbia.edu>;
 Wed, 25 Mar 2020 11:17:00 -0400 (EDT)
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
 [209.85.166.65])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EBFB24A4CD
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Mar 2020 11:16:59 -0400 (EDT)
Received: by mail-io1-f65.google.com with SMTP id c19so2583961ioo.6
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Mar 2020 08:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9RGHKxNbbnl/s4SmG5NdZhXSU8xB6QWkp3vD/nnEXdQ=;
 b=qNFbj0zmmpZYr7uKM8J7jzwlFkp3/oK+09Jtl7asSlyGxlS486Kezm77V/3MtSEMno
 fW3hVmHhXU14kpel4gG/Z1xg3nfey4dplu4o/+bakM/f/A6kmsxu4C1cpL5Z6sUn40YB
 0C7NGCxv3ElTOlSTJC1GFoJ0q2dtqQ+x4cCTgUtL5yFplF3RXvadbMMu4HLjKgHhheIf
 eMNW98F2Jq27GqXdXBx/hAZuAQhzwfW7wsegTJ4grlpjKr5ei2UUTUiIhQggLdBRGMPp
 irTc6RIOFoBUg3uxmc0dn60FeF2yyp+0Gg3qbnBnmxNuVTB1dHL3QkO8BAQfB7ptTfbN
 klOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9RGHKxNbbnl/s4SmG5NdZhXSU8xB6QWkp3vD/nnEXdQ=;
 b=VkRKqRhyfMWZ1UegUqxSE1E9UXqCDzmiONlR7A2CuAHGEVQbRWP0ofn7yYXcJ43n/c
 oM0fjIAX7K2XXj/cmL8RLbCJnvMzdzIicUI7xJRbHfxXWrqByiHiP/X0vfMFdM4vwzU8
 Duoddx4jMfwZLjPJp/ZkbQup8SoiM5Pgs2EBRFvyFCOdl9vYGSfg/Et/qLqegygP7yJ9
 BT1+KBeg3PXHpChYAydaLh4Ow1+K0DzKUXLSTVqle84jrpG0cOeoQhqt+CalL8YRGkv4
 3YhOwdeVqtZDFkiVwd+Nepj4YKUrPjQe17IaFp0o+hJP/5LeGl4ko90epqjQiPygDF5m
 7D8g==
X-Gm-Message-State: ANhLgQ1ua17/x+MEgwMxEea30vppBlCOLh/BI755y5XhVmPjRqHmlFNP
 oHyVUNWX4M0dQ89FEqMXj0ipA22eQmRrSGcWrIBtsw==
X-Google-Smtp-Source: ADFU+vtiYL30PNCMxaUigbiLawILpk5RA5aaHfFoG4N3RszvvhUgvausmB69gR+PBEN213OVwHhebz5+d6npj6zlDjw=
X-Received: by 2002:a02:2944:: with SMTP id p65mr3247806jap.89.1585149419207; 
 Wed, 25 Mar 2020 08:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200323113227.3169-1-beata.michalska@linaro.org>
 <20200323113227.3169-3-beata.michalska@linaro.org>
 <fdf4d6f2-ecab-6358-9f74-480f1fa6fdef@linaro.org>
In-Reply-To: <fdf4d6f2-ecab-6358-9f74-480f1fa6fdef@linaro.org>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Wed, 25 Mar 2020 15:16:48 +0000
Message-ID: <CADSWDzsuGXBwZLm-rJ7ULbODVk4SgoNvXHqJM_BR-gYJNeMB+w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] target/arm: kvm: Handle potential issue with dabt
 injection
To: Richard Henderson <richard.henderson@linaro.org>
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

On Mon, 23 Mar 2020 at 18:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 3/23/20 4:32 AM, Beata Michalska wrote:
> >      uint8_t ext_dabt_pending; /* Request for injecting ext DABT */
> > +    uint8_t ext_dabt_raised; /* Tracking/verifying injection of ext DABT */
>
> Is there a reason these are uint8_t and not bool?
>
>
The ext_dabt_pending is reflecting the KVM type.
The ext_dabt_raised is following that one.

BR
Beata
> r~
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
